#!/usr/bin/env python2.7
"""Edit a file in the host nvim instance."""
from __future__ import print_function
import my_neovim_helper
import argparse
import os
import sys

nvim = my_neovim_helper.get_nvim()

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-f","--first", help="create a first-tab.", action="store_true")
    parser.add_argument("-p","--previous", help="goto previous tab", action="store_true")
    parser.add_argument("-n","--next", help="goto next tab", action="store_true")
    parser.add_argument("-t","--gototab", help="goto nth tab", type=int, default=-1)
    parser.add_argument("-c","--command", help="execute any command in colon mode")
    parser.add_argument("-N","--ncommand", help="execute any command in normal mode")
    parser.add_argument("-g","--grabPosFile", help="grab a /tmp/vimPos.XXX file. Use .../quick-utility-scripts/check_vim_pos.sh to list all", type=int)
    cmd_options = parser.parse_args()

    return cmd_options

def grabPosFile(nvim, options):
    filetograb="/tmp/vimPos.{}".format(options.grabPosFile)
    if not os.path.exists(filetograb):
        print ("No {} found".format(filetograb))
        sys.exit(1)
    mypid = my_neovim_helper.get_vim_pid(nvim)
    torename="/tmp/vimPos.{}".format(mypid)
    if os.path.exists(torename):
        print ("Huh! my file {} already exists".format(torename))
        sys.exit(1)
    os.rename(filetograb,torename)
    print ("Renamed {} into {}".format(filetograb, torename))

options = parse_args()
if options.previous:
    nvim.command('tabprev')
elif options.next:
    nvim.command('tabnext')
elif options.gototab != -1:
    nvim.command('{}tabnext'.format(options.gototab))
elif options.grabPosFile:
    grabPosFile(nvim, options)
else:
    if options.command or options.ncommand:
        pass
    else:
        #just create a first tab
        nvim.command('0tabnew')
        nvim.command('tabfirst')

if options.command:
    nvim.command(options.command)
elif options.ncommand:
    nvim.command('normal ' + options.ncommand)
