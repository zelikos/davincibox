# davincibox

This project aims to provide a ready-to-go container with all of the needed dependencies to install and run DaVinci Resolve on Linux, based on information compiled by bluesabre in his [GitHub Gist](https://gist.github.com/bluesabre/8814afece711b0ca49de34c41e50b296). Davincibox is primarily intended for users of image-based systems such as Fedora Atomic Desktops and Universal Blue images, but it can be used on any Linux distro that distrobox is available on.

## Disclaimers

### GPU Support

My own testing for davincibox has been with an AMD RX 6600XT GPU, and more recently on an Intel Core Ultra 5 125H (i.e. Intel Arc integrated graphics). However, other users have contributed test results here: [#21](https://github.com/zelikos/davincibox/issues/21)

On AMD with ROCm (AMD's official compute package), DaVinci Resolve does not work at all, and has not for quite some time. Davincibox defaults to `rusticl` for AMD GPUs instead now, but this still has its own caveats: Fusion and Fusion FX have poor performance, and may crash DaVinci Resolve and/or your GPU altogether. Non-Fusion effects generally work fine.

On Intel via `intel-compute-runtime`, DaVinci Resolve has been much more stable and with better performance in Fusion. Intel can also be used with `rusticl`, but this generally shouldn't be needed since `intel-compute-runtime` works just fine.

I do not have an NVIDIA GPU at this time and **cannot** directly troubleshoot issues with using them. Support and troubleshooting for NVIDIA-related issues is very reliant on members of the community.

### DaVinci Resolve Studio

Davincibox has had limited testing with DaVinci Resolve Studio. Use at your own risk. See [#26](https://github.com/zelikos/davincibox/issues/26)

### Codecs

DaVinci Resolve on Linux, especially the free version, has [limited codec support](https://documents.blackmagicdesign.com/SupportNotes/DaVinci_Resolve_19_Supported_Codec_List.pdf?_v=1723705210000). Unless you can show that certain codecs are available when using DaVinci Resolve outside of davincibox, but not when using davincibox, **do not** report issues about missing codecs here.

## Requirements & GPU Information

You will need [Podman](https://podman.io/), as well as [`distrobox`](https://github.com/89luca89/distrobox) or [`toolbox`](https://github.com/containers/toolbox).

You will also need the latest release of DaVinci Resolve from [Blackmagic's website](https://www.blackmagicdesign.com/products/davinciresolve).

If you're less comfortable in the CLI, I recommend using the `setup.sh` script from this repository to help simplify the setup process, but ultimately use of the CLI is a requirement.

**Important**: Ensure `lshw` is installed on your system, as `setup.sh` uses it to detect whether you are using an Nvidia GPU or not. This is pre-installed on Universal Blue images, but you may need to install it yourself on other Linux distributions.

### AMD

AMD uses Mesa's `rusticl` for OpenCL support in DaVinci Resolve, due [various](https://github.com/ROCm/ROCm/issues/768) [issues](https://github.com/zelikos/davincibox/issues/65) with AMD's official option, ROCm. These issues largely stem from the fact that [GPU support in ROCm is very limited](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/reference/system-requirements.html#supported-gpus).

ROCm does remain available as a fallback option:

  - Distrobox: `distrobox enter -n davincibox -- /usr/bin/run-davinci rocm`
  - Toolbox: `toolbox run -c davincibox /usr/bin/run-davinci rocm`

If ROCm does work better for you and you would like to launch Resolve with ROCm via the desktop shortcut, you can also adjust the `DaVinciResolve.desktop` file in `$HOME/.local/share/applications`.

Change the `Exec=` line as follows:

  - Distrobox: `Exec=distrobox-enter -n davincibox -- /usr/bin/run-davinci rocm %u`
  - Toolbox: `Exec=/usr/bin/toolbox run -c davincibox /usr/bin/run-davinci rocm %u`

### Intel

For Intel GPUs, the `intel-compute-runtime` package is included and used by default.

`rusticl` is available to test as an alternative for Intel users. Similar to running ROCm for AMD as shown above, you can use `run-davinci rusticl` in the container to use `rusticl` instead of the `intel-compute-runtime`:

  - Distrobox: `distrobox enter -n davincibox -- /usr/bin/run-davinci rusticl`
  - Toolbox: `toolbox run -c davincibox /usr/bin/run-davinci rusticl`

### NVIDIA

NVIDIA users will need to install the `nvidia-container-toolkit` on their host OS. If you are using a [Universal Blue](https://universal-blue.org/) image such as [Bluefin](https://projectbluefin.io/), this will already be installed. Otherwise, see [NVIDIA's installation guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) for instructions for your distribution.

You may additionally need to add a SELinux policy to allow containers to use your GPU. See the "Adding the SELinux policy module" in this [guide](https://www.redhat.com/en/blog/how-use-gpus-containers-bare-metal-rhel-8). Otherwise, you may get an "Unsupported GPU processing mode" error when launching Resolve.

## Setup

### CLI:

Open a terminal, then run `chmod +x /path/to/setup.sh`

Then, `/path/to/setup.sh /path/to/DaVinci_Resolve_versionnumber_Linux.run`

### GUI:

If you're more comfortable in a GUI:

If you're using GNOME, open Files and navigate to where you downloaded the script to. In the example below, the script is in the same folder that I extracted the DaVinci Resolve download to. I recommend you do the same for ease of use, as the rest of the instructions will assume you have done so.

![](screenshots/setup_01.webp)

Right-click, and select Properties.

![](screenshots/setup_02.webp)

Then, make sure "Executable as Program" is toggled on.

![](screenshots/setup_03.webp)

Right-click on an empty spot in the folder. You should see either "Open in Console" as in the screenshot, or "Open in Terminal." Either will be fine.

![](screenshots/setup_04.webp)

In the newly-opened terminal window, enter the command below. Replace 'version' with the version of DaVinci Resolve that you are installing (see screenshot for example):

```
./setup.sh ./DaVinci_Resolve_version_Linux.run
```

![](screenshots/setup_05.webp)

Then, follow any further prompts in the installation script.

### Manual

#### Setup Davincibox

First, get davincibox set up. There are two different builds of davincibox, depending on whether you use an NVIDIA GPU or not:

**NVIDIA Users**

Distrobox:

```
distrobox create -i ghcr.io/zelikos/davincibox:latest --nvidia -n davincibox
```

Toolbox:

```
toolbox create -i ghcr.io/zelikos/davincibox:latest -c davincibox
```

**Intel & AMD Users**

Distrobox:

```
distrobox create -i ghcr.io/zelikos/davincibox-opencl:latest -n davincibox
```

Toolbox:

```
toolbox create -i ghcr.io/zelikos/davincibox-opencl:latest -c davincibox
```

#### Install DaVinci Resolve

On the host, run `--appimage-extract` on your DaVinci Resolve installer

```
/path/to/DaVinci_Resolve_version_Linux.run --appimage-extract
```

Then, run `setup-davinci squashfs-root/AppRun distrobox/toolbox` from within the container

e.g.

Distrobox:

```
distrobox enter davincibox -- setup-davinci squashfs-root/AppRun distrobox
```

Toolbox:

```
toolbox run --container davincibox setup-davinci squashfs-root/AppRun toolbox
```

The suffix at the end is for the `add-davinci-launcher` script. If omitted, setup will still run, but adding the launcher to your application menu won't work.

You can still run `add-davinci-launcher` separately, as either `add-davinci-launcher distrobox` or `add-davinci-launcher toolbox`, depending on what you're using.

After installation completes, you can remove the `squashfs-root` directory.

After setup, run `sudo dnf update` in the container to ensure drivers are up to date:


Distrobox:

```
distrobox enter davincibox -- sudo dnf update
```

Toolbox:

```
toolbox run -c davincibox sudo dnf update
```

## Upgrading

Usually, you'll only need to update the packages in the container (i.e. driver updates), not the container image itself. In this case, simply run `sudo dnf update` in davincibox as shown above.

Otherwise, a full upgrade requires re-creating the davincibox container with the newest version of the image. This should only needed if there has been a new GitHub release for davincibox, as this may include changes to the `setup-davinci` or `add-davinci-launcher` scripts. **When reporting issues, a full upgrade should be performed first**.

If a new version of davincibox is available and you need to upgrade, you can do so manually or with `setup.sh`.

### `setup.sh`

Run `setup.sh upgrade`, then follow the installation steps above.

### Manual

First, run `podman image pull ghcr.io/zelikos/davincibox:latest`

Then, follow the Uninstallation section below and go through manual setup again.

## Uninstallation

Run `./setup.sh remove`, or

Distrobox:

```
# If you are upgrading, you can avoid this line
distrobox enter davincibox -- add-davinci-launcher remove

distrobox stop davincibox
distrobox rm davincibox
```

Toolbox:

```
# If you are upgrading, you can avoid this line
toolbox run --container davincibox add-davinci-launcher remove

podman container stop davincibox
toolbox rm davincibox
```

## Troubleshooting
### No Audio output
DaVinci Resolve uses ALSA. In `davincibox` this is supported via the `pipewire-alsa` plugin, which re-directs sound to pipewire.
This however requires that the host system provides a pipewire server. If your host-system uses some other sound server, this might not work.

You can either convert your host system to provide `pipewire` or change your `davincibox` instance to use any sound server you have running.

For example, if your host-system uses `pulseaudio`, you can change `davincibox` as follows:

```
> distrobox-enter -n davincibox
> sudo dnf remove pipewire-alsa
> sudo dnf install alsa-plugins-pulseaudio
```

## Credits

Sean Davis, AKA [bluesabre](https://github.com/bluesabre)
- For putting together [this Gist](https://gist.github.com/bluesabre/8814afece711b0ca49de34c41e50b296); davincibox's Containerfile and setup scripts were heavily based on that information

[Jorge Castro](https://github.com/castrojo) and [Universal Blue](https://github.com/ublue-os)
- Jorge's blog post about [declaring distroboxes](https://www.ypsidanger.com/declaring-your-own-personal-distroboxes/) planted the seed for davincibox to become a thing
- Pretty much everything on the GitHub CI part of this was originally based on [uBlue's Boxkit](https://github.com/ublue-os/boxkit)
