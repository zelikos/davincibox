# Troubleshooting DaVinci Resolve 20.0.1 in davincibox

## Environment

- DaVinci Resolve 20.0.1.0006
- Fedora Toolbox 42 base image (davincibox)
- Distrobox container manager
- NVIDIA RTX A2000 8GB (hybrid Intel/NVIDIA system)
- NVIDIA Driver 580.126.09


## Issue

DaVinci Resolve 20.0.1 crashes with a segmentation fault immediately after startup when launched via `run-davinci` inside a distrobox container.

## Root Causes

Three issues were identified:

### 1. `switcherooctl launch` crashes DaVinci when an NVIDIA GPU is present

When an NVIDIA GPU is detected (via `driver=nvidia`), `switcherooctl launch` sets PRIME offload environment variables (`__NV_PRIME_RENDER_OFFLOAD=1`, `__GLX_VENDOR_LIBRARY_NAME=nvidia`, etc.) that crash DaVinci Resolve. This affects both hybrid Intel/NVIDIA systems and pure NVIDIA systems.

**Fix (in `run-davinci`):** Skip `switcherooctl` entirely when an NVIDIA GPU is detected and launch DaVinci directly. DaVinci handles NVIDIA GPU selection internally. Non-NVIDIA GPUs (AMD, Intel) still use `switcherooctl launch` as before.

### 2. Broken `LD_LIBRARY_PATH` inherited from host

The host system can have `LD_LIBRARY_PATH` set to invalid values (e.g. pointing to a file instead of a directory). Distrobox passes all host environment variables into the container, which can break library loading.

**Fix (in `run-davinci`):** `unset LD_LIBRARY_PATH` at the start of the script.

### 3. Corrupt or empty `config.dat` causes segfault on startup (might be related to previous issues and killing the app)

DaVinci Resolve can truncate `config.dat` to 0 bytes if terminated unexpectedly (e.g. via `kill -9` or system crash). On the next launch, it tries to read the empty file, fails the assertion `m_SiteEnabledIdx > 0` in `AppConfig::LoadAllSiteInfo()`, and crashes with SIGABRT/SIGSEGV.

**Crash signature:**
```
resolve: AppConfig.cpp:260: void AppConfig::LoadAllSiteInfo(): Assertion `m_SiteEnabledIdx > 0' failed.
Signal Number = 6
```

**Fix (in `run-davinci`):** Before launching, detect empty `config.dat` files, remove them, and restore from the system default at `/opt/resolve/share/default-config.dat`. Also restore `log-conf.xml` from `/opt/resolve/share/log-conf.xml` if missing or empty.

**Manual fix:**
```bash
cp /opt/resolve/share/default-config.dat ~/.local/share/DaVinciResolve/configs/config.dat
cp /opt/resolve/share/log-conf.xml ~/.local/share/DaVinciResolve/configs/log-conf.xml
```



## Code Changes in `run-davinci`

```bash
# Near the top, after QT exports:
unset LD_LIBRARY_PATH

# Before launching DaVinci:
# Auto-recover from corrupted/empty config.dat
RESOLVE_CONFIG_DIR="${HOME}/.local/share/DaVinciResolve/configs"
DEFAULT_CONFIG="/opt/resolve/share/default-config.dat"
for cfg in "$RESOLVE_CONFIG_DIR/config.dat" "$RESOLVE_CONFIG_DIR/.config.data"; do
  if [[ -f "$cfg" && ! -s "$cfg" ]]; then
    rm -f "$cfg"
  fi
done
if [[ ! -f "$RESOLVE_CONFIG_DIR/config.dat" && -f "$DEFAULT_CONFIG" ]]; then
  mkdir -p "$RESOLVE_CONFIG_DIR"
  cp "$DEFAULT_CONFIG" "$RESOLVE_CONFIG_DIR/config.dat"
fi
if [[ ! -s "$RESOLVE_CONFIG_DIR/log-conf.xml" && -f /opt/resolve/share/log-conf.xml ]]; then
  cp /opt/resolve/share/log-conf.xml "$RESOLVE_CONFIG_DIR/log-conf.xml"
fi

# Skip switcherooctl for NVIDIA GPUs:
if [[ "$GPU_TYPE" == "nvidia" ]]; then
  "$DAVINCI_BIN"
elif dbus_socket="$(get_host_dbus_socket)"; then
  DBUS_SYSTEM_BUS_ADDRESS="unix:path=$dbus_socket" switcherooctl launch "$DAVINCI_BIN"
else
  switcherooctl launch "$DAVINCI_BIN"
fi
```

### DBUS socket path (applied to both `run-davinci` and `list-gpus`)

Both scripts had a hardcoded DBUS socket path (`/run/host/var/run/dbus/system_bus_socket`) that does not exist on all distros. Replaced with `get_host_dbus_socket()` that checks both `/run/host/var/run/dbus/system_bus_socket` and `/run/host/run/dbus/system_bus_socket`, using whichever socket is present.

## Diagnosis Steps

1. **Check NVIDIA GPU access:** `distrobox-enter -n davincibox -- nvidia-smi` — confirmed working.
2. **Check DBUS socket:** Only `/run/host/run/dbus/system_bus_socket` existed (not the hardcoded path).
3. **Check `LD_LIBRARY_PATH`:** Set to a file path on the host, leaking into the container.
4. **Get crash backtrace:** `coredumpctl info` revealed `AppConfig::LoadAllSiteInfo()` assertion failure.
5. **Trace startup:** `strace` showed DaVinci reads `config.dat` early and crashes when it's empty.
6. **Test `switcherooctl`:** `switcherooctl list` worked, but `switcherooctl launch` set PRIME offload vars that crash DaVinci.
7. **Found default config:** `/opt/resolve/share/default-config.dat` confirmed a recoverable default exists. `/opt/resolve/scripts/script.start` (DaVinci's own startup wrapper) showed it sets `LD_LIBRARY_PATH` internally, confirming the host value should not be inherited.