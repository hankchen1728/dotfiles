# Setting for Alacritty

## Installation
- For **macOS** and **Windows**, download the prebuilt binaries from [GitHub releasesage](https://github.com/alacritty/alacritty/releases).
    - If installing the binaries on macOS, you can make a soft link of `/Applications/Alacritty.app/Contents/MacOS/alacritty` to one of the path in the environment variable `$PATH`, then it will be able to call the command `alacritty` directly, for example:
    ```
    $ ln -s /Applications/Alacritty.app/Contents/MacOS/alacritty ~/.local/bin/alacritty
    ```
- Otherwise, see the detail installation [ instruction ](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)

## Configuration
1. Download the default [ configuration file ](https://github.com/alacritty/alacritty/blob/master/alacritty.yml)
2. Edit the `alacritty.yml` file and move it to `$HOME/.config/alacritty/alacritty.yml` (for **macOS** and **Linux**)

### Meta key on macOS
Add put the following key binding in the `alacritty.yml`, for detail, see [issue#62](https://github.com/alacritty/alacritty/issues/62),
```
- { key: A,         mods: Alt,       chars: "\x1ba"                        }
```
