---
title: "Installing nodejs on macOS Apple Silicon (M1)"

categories:
  - NodeJS
  - Apple Silicon
  - macOS
date:  2021-01-18T20:16:12-0500
---

I recently bought a new MacBook Pro with the M1 Apple Silicon CPU. While most things seem to be working great, some developer tools are not yet distributed as native aarch64 binaries. Currently, nodejs is one of those tools. The developers are working on [official support](https://github.com/nodejs/build/issues/2474), but it isn't available yet. Fortunately thanks to the [nvm](https://github.com/nvm-sh/nvm) project it is still easy to get up and running.

First, if you do not already have the xcode command line tools installed you should install them. This will download the needed C++ compiler and other development tools. Do this by running:

```bash
sudo xcode-select --install
```

Once that completes, install nvm per their instructions. The command will look something like the following (to ensure you get the latest version of nvm use the command from [Github](https://github.com/nvm-sh/nvm#install--update-script)).

Note that if you do not already have a profile file (~/.bash_profile, ~/.zshrc, ~/.profile, or ~/.bashrc) for your shell it won't be able to install correctly. You should create the appropriate file(s) first before running the command below.

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
```

Now that you have nvm installed you can run the following command to install node. Version 15 is the one that currently (Jan 2021) works on aarch64 for Mac. 

```bash
nvm install v15
```

If everything works correctly this step will take a while to compile everything and copy the newly buily node to the correct install location inside the `~/.nvm` directory. After the build and install completes test the install by running: 

```bash
node --version
```

You will probably need to close and re-open your terminal for the command to be found.

Finally, you will want to clear the nvm cache to reduce clutter. After the build mine was consuming about 11GB, vs about 100MB once the cache was cleared. This can be done using: 

```bash
nvm cache clear
```

Hopefully, this helps someone else that is also on the bleeding edge of Apple hardware!
