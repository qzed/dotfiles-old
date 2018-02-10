#!/usr/bin/env python

import sys
import subprocess
import os
from pathlib import Path


EXEC_ANSIBLE_PLAYBOOK = 'ansible-playbook'
PLAYBOOK_NAME = Path('setup.yaml')
PLAYBOOK_DIR = Path('../../manager')


def main():
    sys.stdout.write('Re-install dotfiles? This will overwrite all changes! [Y/n] ')
    choice = input().lower()

    if choice not in ['y', '']:
        sys.stdout.write('Aborting...\n')
        return

    cwd = Path(os.path.dirname(__file__)) / PLAYBOOK_DIR
    command = [EXEC_ANSIBLE_PLAYBOOK, PLAYBOOK_NAME]
    subprocess.check_call(command, cwd=cwd)

if __name__ == '__main__':
    main()
