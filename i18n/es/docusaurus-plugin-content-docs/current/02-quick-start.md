# Inicio Rápido

Si todo salió bien en la instalación, deberías poder iniciar LunarVim con el comando `lvim`.

## Añadir `lvim` en `$PATH`

Si tu terminal no reconoce el comando `lvim` [agregue la carpeta de instalación en el path de su sistema ](https://gist.github.com/nex3/c395b2f8fd4b02068be37c961301caa7) o cambie el commando `lvim` a donde sea que este su path, por defecto la carpeta de instalacion es `~/.local/bin`.

## Tree-sitter

Para instalar el resaltado de sintaxis y el soporte treesitter para su lenguaje:

```vim
:TSInstall <TAB>
```

**NOTA:** `<TAB>` indica que debe presionar la tecla `<TAB>` y desplazarse por sus opciones

No se admiten todos los idiomas. Para obtener una lista de los idiomas admitidos [mira aquí](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages).
<iframe width="560" height="315" src="https://www.youtube.com/embed/hkxPa5w3bZ0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="1"></iframe>

## Servidor de Lenguajes

Para instalar un servidor de lenguaje para para su lenguaje:

```vim
:LspInstall <TAB>
```

Algunas veces el servidor de lenguaje no tendrá un nombre obvio. Por ejemplo, el servidor de lenguaje para Ruby es Solargraph. Metals es el servidor de lenguaje para Scala, etc. Para buscar su servidor de lenguaje correspondiente [mire aquí](https://github.com/williamboman/nvim-lsp-installer).

## Formateo y Linting

El Formateo y el Linting no son compatibles con algunos LSP de forma predeterminada.
Estos deben instalarse / configurarse por separado.

Ver [lenguajes](./languages/) donde se puede abordar cada idioma con su formateo y rodado.

## Fuentes Nerd

Se recomienda instalar una [nerd font](https://www.nerdfonts.com/). De lo contrario, algunos símbolos no se representarán correctamente. Para obtener más información, vaya a la [sección de configuración](./configuration/nerd-fonts).

## Siguientes Pasos

- Aprenda como [configurar LunarVim](./configuration/).
- Más información sobre los [plugins instalados](./plugins/).
- Aprenda a configurar LunarVim para su [lenguaje](./languages/).
