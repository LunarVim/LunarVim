# Snippets personalizados

## Descripción

El termino snippet proviene del ingles y hace referencia a una parte reusable de código, en este apartado vamos a utilizar el término en ingles para evitar confusiones con su traducción en español.

Puedes agregar tus propios snippets a LunarVim, estos pueden estar escritos en json o en lua.

### Versión en formato json

Lo primero que debes hacer, es crear una carpeta llamada `snippets` justo en la misma ruta de tu `config.lua`, debe quedar de esta forma `~/.config/lvim/snippets/`.

Aqui vas a necesitar por lo menos dos archivos.

El primer archivo, es el que describe la ruta para tus snippets:

`package.json`

```json
{
    "name": "nvim-snippets",
    "author": "authorname",
    "engines": {
        "vscode": "^1.11.0"
    },
    "contributes": {
        "snippets": [
            {
                "language": "python",
                "path": "./python.json"
            }
        ]
    }
}
```

Para cada lenguaje en el que quieras un snippet, debes crear un archivo de esta forma:

`python.json`

```json
{
  "hola": {
    "prefix": "hola",
    "body": [
      "print('Hola, Mundo!')"
    ],
    "description": "Imprimir Hola, Mundo!"
  }
}
```

Eso es todo! ahora tienes un snippet personalizado, eso quiere decir que cuando escribas `hola` vas a obtener una opción para autocompletar a `print("Hola, Mundo!")`.

### Versión en formato lua

Lo primero que debes hacer, es crear una carpeta llamada `luasnippets` justo en la misma ruta de tu `config.lua`, debe quedar de esta forma `~/.config/lvim/luasnippets/`.

Ahora, dentro de esta carpeta, debes crear un archivo cuyo nombre sea el tipo de archivo al que quieres agregar snippets. Por ejemplo, queremos crear snippets para python, entonces el nombre del archivo debe ser `py.lua`. Dentro de este archivo, declaramos los snippets de esta forma:

```lua
return {
  s("foo", { t "Ejemplo de snippet :D" }),
}
```

Gracias a LuaSnip, solo debes reiniciar LunarVim la primera vez que escribas snippets, luego puedes escribir y utilizar snippets sin necesidad de reiniciar.
Cabe resaltar que LuaSnip otorga un montón de utilidades de manera global cuando carga tus snippets, de esta forma no debes preocuparte en definir las funciones que usaste para definirlos. Para mas información y ejemplos por favor lee la [documentación de LuaSnip](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua)
