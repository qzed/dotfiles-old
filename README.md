# Personal Configuration Files

Contains configuration files for
- user environment (environment-variables like `PATH` and modification thereof, `.profile`, and `.zlogin`)
- zsh (key bindings, basic completion, ...)
- LS_COLORS (loaded via `.profile` or `.zlogin`)


## Installation

Automated installation requires ansible.


### The easy way

Simply run `./dot.py install` to install/update the configuration files. Note: This will overwrite all files already present in the target locations (i.e. `$HOME/.zshrc`).
Additionally, you can install git `post-merge` and `post-checkout` hooks to automatically trigger re-installation of the dotfiles on `git pull` and `git checkout` using `./dot.py githook install`.
See `./dot.py -h` for more information on this.


### The manual way
[manual installation]: #the-manual-way

Run

```sh
cd manager && ./setup.yaml
```

or alternatively

```sh
cd manager && ansible-playbook setup.yaml
```

This allows you to specify additional command-line-arguments for the `ansible-playbook` command.
As with the simple installation, this will overwrite all files that are already present in the target locations.


## Configuration

By editing `manager/setup.yaml` you can configure what is going to be installed.
Just remove the roles you do not want.
You could also add your own roles in `manager/roles` and specify them here.

For proper categorization, the configuration files are stored in `dotfiles` and symlinked to the respective ansible role file-folder.

By default the configuration files are installed to the current user's home directory of `localhost`.
You can change the network target by editing the ansible hosts file (`manager/inventory/hosts.yaml`), the user by specifying `--become-user <username>` to the `ansible-playbook` command (see [manual installation]), and the target directories by changing the path(s) in `manager/roles/paths/vars/main.yaml`.


## License

These configuration files are distributed under the Unilicense.
See [LICENSE](LICENSE) for details.
