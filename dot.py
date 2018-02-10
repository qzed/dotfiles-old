#!/usr/bin/env python

import argparse
import subprocess
import os
import sys
import shutil
from pathlib import Path


EXEC_ANSIBLE_PLAYBOOK = 'ansible-playbook'
PLAYBOOK_NAME = Path('setup.yaml')
PLAYBOOK_DIR = Path('./manager')

GIT_HOOKS_DIR = Path('.git/hooks')
AUTOINSTALL_HOOK = Path('manager/githooks/autoinstall.py')


def base_path():
    return Path(os.path.dirname(__file__))

def install():
    cwd = base_path() / PLAYBOOK_DIR
    command = [EXEC_ANSIBLE_PLAYBOOK, PLAYBOOK_NAME]
    subprocess.check_call(command, cwd=cwd)

def githook_install():
    dst_post_checkout = base_path() / GIT_HOOKS_DIR / 'post-checkout'
    dst_post_merge = base_path() / GIT_HOOKS_DIR / 'post-merge'
    src_hook = base_path() / AUTOINSTALL_HOOK

    sys.stdout.write('Install `post-checkout` hook [Y/n] ')
    choice_checkout = input().lower() in ['y', '']

    if choice_checkout:
        if dst_post_checkout.exists():
            sys.stderr.write("Error: `post-checkout` hook already exists\n")
        else:
            shutil.copyfile(src_hook, dst_post_checkout)
            os.chmod(dst_post_checkout, 0o775)

    sys.stdout.write('Install `post-merge` hook [Y/n] ')
    choice_merge = input().lower() in ['y', '']

    if choice_merge:
        if dst_post_merge.exists():
            sys.stderr.write("Error: `post-merge` hook already exists\n")
        else:
            shutil.copyfile(src_hook, dst_post_merge)
            os.chmod(dst_post_merge, 0o775)

def githook_uninstall():
    path_post_checkout = base_path() / GIT_HOOKS_DIR / 'post-checkout'
    path_post_merge = base_path() / GIT_HOOKS_DIR / 'post-merge'

    if path_post_checkout.exists():
        sys.stdout.write('Remove `post-checkout` hook [Y/n] ')
        choice = input().lower() in ['y', '']

        if choice:
            os.remove(path_post_checkout)

    if path_post_merge.exists():
        sys.stdout.write('Remove `post-merge` hook [Y/n] ')
        choice = input().lower() in ['y', '']

        if choice:
            os.remove(path_post_merge)


def main():
    # Set-up parser
    parser = argparse.ArgumentParser(description='Manage configuration files.')
    sub_main = parser.add_subparsers(dest='subcommand')

    sub_main.add_parser('install', help='Install dotfiles')

    p_githook = sub_main.add_parser(
        'githook',
        help='Manage git-hook for automated dotfile installation')

    sub_githook = p_githook.add_subparsers(dest='githook')
    sub_githook.add_parser('install',   help='Install git-hook for automated installation')
    sub_githook.add_parser('uninstall', help='Uninstall a previously installed git-hook')

    args = parser.parse_args()

    # Check for validity
    if args.subcommand is None:
        print("Error: Missing subcommand, see `{} -h` for help.".format(__file__))
        return

    if args.subcommand == 'githook' and args.githook is None:
        print("Error: Missing subcommand for `githook`, see `{} githook -h` for help.".format(__file__))
        return

    # Execute subcommand
    if args.subcommand == 'install':
        install()
    elif args.subcommand == 'githook' and args.githook == 'install':
        githook_install()
    elif args.subcommand == 'githook' and args.githook == 'uninstall':
        githook_uninstall()


if __name__ == '__main__':
    main()
