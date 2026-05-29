# Dotfiles

My config files

## Usage

```
curl -fsSL https://raw.githubusercontent.com/sankantsu/dotfiles/main/bootstrap.sh | bash
```

To bootstrap from a specific branch:

```
curl -fsSL https://raw.githubusercontent.com/sankantsu/dotfiles/main/bootstrap.sh | bash -s -- -b <branch>
```

## Edit "hidden" files

README.md and bootstrap.sh are not checked out because those files don't need to persist in the home directory.
To edit these files for development, you need to disable sparse-checkout:

```
yadm sparse-checkout disable
```

To reinitialize sparse-checkout, explicitly set no-cone mode to avoid the `unrecognized pattern` warning.

```
yadm sparse-checkout init --no-cone
```
