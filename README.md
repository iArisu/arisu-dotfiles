# My own dotfiles

## Dependencies:
* [quickshelll-overview](https://github.com/Shanu-Kumawat/quickshell-overview/) (bundled)
* Quickshell 0.2.1 (aur)
* Awww 0.11.2-master2 (aur)
* fuzzel
* kitty
* dolphin
* chafa

## Code reused / Inspiration
### [end-4's dotfiles](https://github.com/end-4/dots-hyprland)

## Using
Note: you need to delete previous folder / symlinks at
`~/.config/hypr`, `~/.config/quicksell/arisu`, ...

```shell
$ git clone https://github.com/Chaikew/arisus-dotfiles ~/arisus-dotfiles

$ sudo pacman -S hyprland kitty fuzzel dolphin chafa flameshot zenity --noconfirm

$ yay --aur quickshell-git awww

$ ln -s $(readlink -fs ~/arisus-dotfiles/.config/fish/) ~/.config/
$ ln -s $(readlink -fs ~/arisus-dotfiles/.config/hypr/) ~/.config/
$ ln -s $(readlink -fs ~/arisus-dotfiles/.config/flameshot/) ~/.config/
$ ln -s $(readlink -fs ~/arisus-dotfiles/.config/fuzzel/) ~/.config/
$ ln -s $(readlink -fs ~/arisus-dotfiles/.config/quickshell/arisu/) ~/.config/quickshell/
```