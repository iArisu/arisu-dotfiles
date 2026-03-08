# My own dotfiles

## Dependencies:
* [quickshelll-overview](https://github.com/Shanu-Kumawat/quickshell-overview/) (bundled)
* Quickshell 0.2.1 (aur)
* Awww 0.11.2-master2 (aur)

## Code reused / Inspiration
### [end-4's dotfiles](https://github.com/end-4/dots-hyprland)

## Using
Note: you need to delete previous folder / symlinks at
`~/.config/hypr` and `~/.config/quicksell/arisu`

```shell
$ git clone https://github.com/Chaikew/arisus-dotfiles ~/.arisus-dotfiles

$ ln -s $(readlink -fs ~/.arisus-dotfiles/.config/quickshell/arisu/) ~/.config/quickshell/arisu

$ ln -s $(readlink -fs ~/.arisus-dotfiles/.config/hypr/) ~/.config/hypr
```