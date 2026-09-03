# Homebrew tap for cmux GTK

This tap distributes the Linux build of
[cmux GTK](https://github.com/nitecon/cmux-gtk).

## Install

Homebrew 6 requires explicit trust before loading Casks from third-party taps.
Trust only the cmux GTK Cask, then install it:

```sh
brew tap nitecon/cmux-gtk
brew trust --cask nitecon/cmux-gtk/cmux-gtk
brew install --cask nitecon/cmux-gtk/cmux-gtk
```

The trust decision is stored by Homebrew for future upgrades. It applies only
to `cmux-gtk`, not every current or future Cask in this tap.

Launch cmux from your desktop application menu or run `cmux-app`. The installed
commands are `cmux` and `cmux-app`.

## Upgrade

```sh
brew upgrade --cask cmux-gtk
```

The Cask is generated from the release template in the main repository and is
updated automatically whenever a `v*` tag publishes a cmux GTK release.
