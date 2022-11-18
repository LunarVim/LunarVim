---
title: Nerd Fonts
---

# [ Nerd Fonts ](https://www.nerdfonts.com/)

Según el repositorio:

> "Nerd Fonts es un proyecto que abarca fuentes de texto con un gran numero de iconos. Especificamente para obtener un gran numero de iconos de proyectos como Font Awesome ➶, Devicons ➶, Octicons ➶, entre otros"

## Instalando una fuente

### Video de explicación

<iframe width="560" height="315" src="https://www.youtube.com/embed/fR4ThXzhQYI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="1"></iframe>

### Instalación fácil

Visita [este repositorio](https://github.com/ronniedroid/getnf) donde encontrarás una forma sencilla de instalar nerd fonts.

### Instalación manual

1. Ve al sitio [descargas de nerd fonts](https://www.nerdfonts.com/font-downloads).
1. Copia los archivos descargados a `~/.local/share/fonts`.

### Descarga por curl

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
```

### TTF vs OTF

OTF es un estándar nuevo, está basado en TTF, cuando exista la opción debes elegir preferiblemente OTF.

[ Aqui ](https://www.makeuseof.com/tag/otf-vs-ttf-fonts-one-better/) encuentras un buen artículo explicándote la diferencia.

## Configuraciones de Terminal

Después de instalar la fuente, vas a tener que refrescar el cache de fuentes ejecutando `fc-cache -f -v`. Luego, vas a ir a cambiar la configuración de tu terminal para usar la fuente que acabas de instalar. En este paso debes ir a la documentación de tu terminal para saber como cambiar la fuente.

