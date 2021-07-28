# Vim shortcuts

## Jumplist/changelist

| Command         |       Description       |
| --------------- | :---------------------: |
| `Ctrl-o  Ctrl-i` |  Cycle through :jumps  |
| `g;  g,`          | Cycle through :changes |

## Buffers

| Command          |            Description            |
| ---------------- | :-------------------------------: |
| :b {filename}    |      go to buffer {filename}      |
| :bd              |       delete current buffer       |
| :buffers         |     print out all the buffers     |
| :bufdo {cmd}     |   execute {cmd} for all buffers   |
| :n               |          go to next file          |
| :arga {filename} |   add { filename } to arg list    |
| :arg1 {files}    |   make a local copy via{files}    |
| :args            | make a local arg copy via {files} |

## Tabs

| Command |     Description      |
| ------- | :------------------: |
| gt      |    go to next tab    |
| gT      |   got to prev tab    |
| :tabc   |      close tab       |
| :tabe   |       open tab       |
| :tabo   | close all other tabs |

## Windows

| Command      |           Description            |
| ------------ | :------------------------------: |
| `<Ctrl-w> s`   |           split window           |
| `<Ctrl-w> v`   |     split window vertically      |
| `<Ctrl-w> q`   |           close window           |
| `<Ctrl-w> w`   |         alternate window         |
| `<Ctrl-w> r`   |          rotate windows          |
| :windo {cmd} |  execute {cmd} for all windows   |
| :sf {FILE}   |  split window and :find {FILE}   |
| :vert {cmd}  | make and split {cmd} be vertical |

## Search

| Command        |             Description              |
| -------------- | :----------------------------------: |
| `/{patt}[/]<CR>` |          search for {patt}           |
| `/<CR>`          |     search for last used pattern     |
| `?{patt}[?]<CR>` |        search back for {patt}        |
| `?<CR>`          |  search back for last used pattern   |
| [count]n       |   repeat last search [count] times   |
| [count]N       |  same as above, opposite direction   |
| `*`             | search forward for word under cursor |
| `#`              |  same as above, opposite direction   |
| gd             |       got to local declaration       |
| :hls!          |      toggle search highlighting      |

## General

| Command | Description |
| ------- | :---------: |
| :!cat .bashrc        |    To run a command externally prefix it with `!`    |
| :read !date        | read in the output of a program             |
| :r !date        | same as above             |
| :g/import/d        |  delete every line that includes the word 'import'           |
| :g!/import/d        | delete every line that doesn't include the word 'import'            |
| :v/import/d        |  same as above but use 'very magic' to avoid escaping characters. :h magic            |
| :g/^/pu \"\n\"        | Put a new linebreak at the start of every line            |
| :g/^\s****$/d        |  Delete all empty lines           |
| :g/import/t$        |   Copy every line that includes the word 'import' to the end of the file          |
| :sort     |    Select a range of text and sort it |

## Ranges
| Command | Description |
| ------- | :---------: |
| :.command         | run a command on the current line            |
| :$command        |  run a command on the whole file           |
| :1,5command        | run a command on a range            |

## Commands

| Command | Description |
| ------- | :---------: |
| :enew|pu=execute('scriptnames') | paste the results of a command to a buffer|

