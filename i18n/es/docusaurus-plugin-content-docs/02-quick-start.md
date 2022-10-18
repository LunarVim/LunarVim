# Inicio Rapido

Si todo salió bien en la instalación, deberías poder iniciar LunarVim con el comando `lvim`.

## Añadir `lvim` en `$PATH`

SI tu terminal no reconoce el comando `lvim` [agregue la carpeta de instalación en el path de su systema ](https://gist.github.com/nex3/c395b2f8fd4b02068be37c961301caa7) o cambie el commando lvim a donde sea que este su path, Por defecto la carpeta de instalacion es `~/.local/bin`.

## Tree-sitter

Para instalar el resaltado de sintaxis y el soporte treesitter para su lenguaje:

```vim
:TSInstall <TAB>
```

**NOTA:** `<TAB>` indica que debe presionar la tecla `<TAB>` y desplazarse por sus opciones

No se admiten todos los idiomas. Para obtener una lista de los idiomas admitidos[mira aquí](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)

## Servidor de Lenguajes

Para instalar un servidor de lenguaje para para su lenguaje

```vim
:LspInstall <TAB>
```

Algunas veces el servidor de lenguaje no tendrá un nombre obvio para el suyo. Por ejemplo, el servidor de lenguaje para ruby es  solargraph. Metals es el servidor de lenguaje para scala, etc. Para buscar su servidor de lenguaje correspondiente[mire aquí](https://github.com/williamboman/nvim-lsp-installer)

## Formateo y Linting

Formateo y Linting no son compatibles con algunos LSP de forma predeterminada.
Esto deben instalarse / configurarse por separados.

Ver [lenguajes](./languages/README.md) donde se puede abordar cada idioma con su formateo y rodado.

## Fuentes Nerd

Se recomienda instalar una [ nerd font](https://www.nerdfonts.com/). De lo contrario, algunos símbolos no se representarán correctamente. Para obtener más información, vaya a la [sección de configuración](./configuration/04-nerd-fonts.md).

## Siguientes Pasos

- Aprenda como [configurar LunarVim](./configuration/README.md)
- Más información sobre los [plugins instalados](./plugins/README.md)
- Aprenda a configurar LunarVim para su [lenguaje](./languages/README.md)
