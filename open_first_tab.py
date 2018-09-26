#!/usr/bin/env python2.7
"""Edit a file in the host nvim instance."""
from __future__ import print_function
import my_neovim_helper

nvim = my_neovim_helper.get_nvim()

nvim.command('0tabnew')
nvim.command('tabfirst')
print ("Reloaded cscope")

