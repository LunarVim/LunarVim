# [ Nerd Fonts ](https://www.nerdfonts.com/)

From the repo:
>"Nerd Fonts is a project that patches developer targeted fonts with a high number of glyphs (icons). Specifically to add a high number of extra glyphs from popular 'iconic fonts' such as Font Awesome ➶, Devicons ➶, Octicons ➶, and others."

## Installing a font

### Video Explanation
[Installing fonts with included icon sets](https://www.youtube.com/watch?v=fR4ThXzhQYI&t=364s)

### Easy Installer
Visit [this repo](https://github.com/ronniedroid/getnf) for an easy way to install nerd fonts.

### Manual Install
1. To to the [pached fonts directory](https://www.nerdfonts.com/font-downloads)
1. Copy the downloaded files to `~/.local/share/fonts`

### Curl Download
```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
```

### TTF vs OTF
OTF is a newer standard based on TTF, when given the option you should generally choose OTF.

[ Here ](https://www.makeuseof.com/tag/otf-vs-ttf-fonts-one-better/) is good article explaining the difference.  

## Terminal settings
After installing your font, you will also have to change your terminal settings to use the font you just installed.  Please refer to your terminal's documentation for changing the terminal font.  
