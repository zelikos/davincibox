# davincibox

This project aims to provide a ready-to-go container with all of the needed dependencies to install and run DaVinci Resolve, based on information compiled by bluesabre in his [GitHub Gist](https://gist.github.com/bluesabre/8814afece711b0ca49de34c41e50b296).

## Requirements

You will need `distrobox` or `toolbox`. Distrobox is highly recommended for ease of use.

If using an Nvidia GPU, you will also need the `nvidia-container-runtime` package installed to your system.

You will also need the latest release of DaVinci Resolve from [Blackmagic's website](https://www.blackmagicdesign.com/products/davinciresolve)

Finally, I recommend that you download the `setup.sh` script from this repository to simplify the setup process.

## Easy Setup

This assumes you're using the `setup.sh` script from this repository.

First, you need to make `setup.sh` executable.

### Option 1

Open a terminal, then run `chmod +x /path/to/setup.sh`

Then, `/path/to/setup.sh /path/to/DaVinci_Resolve_versionnumber_Linux.run`

### Option 2

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

## Manual Setup

First, download DaVinci Resolve from the link above. Then, extract the archive. Open a terminal in the directory that contains the `DaVinci_Resolve_<version>_Linux.run` file (\<version\> will correspond to the version of DaVinci Resolve you downloaded).

In your terminal,

Distrobox:

```
distrobox create -i ghcr.io/zelikos/davincibox:latest -n davincibox
distrobox enter davincibox
```

Toolbox:

```
toolbox create -i ghcr.io/zelikos/davincibox:latest -c davincibox
toolbox enter davincibox
```

Install Resolve (again, replace \<version\> with the version number in the filename):

```
./DaVinci_Resolve_<version>_Linux.run --appimage-extract
cd squashfs-root/
sudo ./AppRun -i -a -y
```

At the time of writing, there is an issue where DaVinci Resolve bundles its own copy of libglib-2.0, but it needs a newer version than what is bundled. To work around this, you can remove Resolve's copy so that it uses the container's version instead:

```
sudo rm /opt/resolve/libs/libglib-2.0.*
```

After installation completes, check that Resolve runs:

```
/opt/resolve/bin/resolve
```

Finally, if using `distrobox`, run the following command to launch Resolve from your desktop environment's application launcher:

```
distrobox-export --app /opt/resolve/bin/resolve
```

Instructions for a similar result with `toolbox` will be added here later. In the meantime, you can reference [bluesabre's Gist](https://gist.github.com/bluesabre/8814afece711b0ca49de34c41e50b296) to see how.