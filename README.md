# Dotfiles

My config files

## Prerequisites

Following tools are necessary for bootstrapping:

- bash
- curl
- git

## Usage

```
curl -fsSL https://raw.githubusercontent.com/sankantsu/dotfiles/main/bootstrap.sh | bash
```

To bootstrap from a specific branch:

```
curl -fsSL https://raw.githubusercontent.com/sankantsu/dotfiles/<branch>/bootstrap.sh | bash -s -- -b <branch>
```

## Structure

### Core tools

- [`yadm`](https://yadm.io/): A Git-based dotfile manager that directly tracks configuration files in `$HOME`.
- [`mise`](https://mise.jdx.dev/): A dev-tool and language manager.

### Structure

Overall, yadm enforces a directory structure that directly mirrors the `$HOME` directory.

Here is some files/directories with additional notes:

- `.config/mise/config.toml`: Global tool configs.
- `.config/profile.d/`: Common shell (bash/zsh) settings.
- `.config/yadm/alt`: OS/machine profile specific settings ([alternates](https://yadm.io/docs/alternates)).

### Bootstrap

- `bootstrap.sh`: Initial bootstrap from clean environment.
- `.config/yadm/bootstrap`: Post bootstrap after populating dotfiles (e.g. mise tool setup)

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

## License

This repository is dedicated to the public domain under the **Creative Commons Zero (CC0 1.0 Universal)** license.
You are free to copy, modify, and distribute my original configurations and scripts without any attribution.
https://creativecommons.org/publicdomain/zero/1.0/deed.en

Please note that this repository may also includes minor code snippets, configuration blocks, or workarounds adapted from third-party sources (such as official documentation, community guides, or MIT/BSD-licensed dotfiles).
Wherever substantial logic was borrowed, the original copyright notices, licenses, or source URLs have been preserved inline directly within the files.
