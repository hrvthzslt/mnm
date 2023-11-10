# mnm - minimalist Note manager

A minimalist note manager focused around three functions: **creating**, **searching** and **arranging** notes in
directories. Created with the help of **rg** and **fzf**.

## Requirements

**Ripgrep** (rg) and **Fzf** (fzf) is installed in your system.

## Recommended Installation method

```shell
ln -s "$(cd "$(dirname "$0")" && pwd)"/mnm.sh "$HOME"/.local/bin/mnm
```

Create a symlink between `mnm.sh` and `./local/bin/mnm`, or you can run `install.sh` which will do the same. After this
the command `mnm` will be available in your system.

## Configuration

First start will create the config file in the following path: `~/.config/mnm.conf`

- `path` defines the root of your notes
- `directories` is the list of the directories you collect your notes

If you list non existing directories, the next usage of the command will create them. If you change the directories
after some time of usage the notes will be not migrated automatically.

## Usage

### Create a note

```shell
mnm -c
```

### Search in notes

```shell
mnm -s
```

### Search in notes in a directory

```shell
mnm -d
```
