#!/usr/bin/env bash
set -e

rsync -avh --no-links --delete --exclude=.* --exclude=dyski /home/szymon/ /mnt/uwu_backup/home/szymon/
rsync -avh --no-links --delete --exclude=.* --exclude=dyski /home/szymon/ /mnt/wd_backup/home/szymon/
