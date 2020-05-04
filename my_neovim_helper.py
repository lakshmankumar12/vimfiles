#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function
import os
import sys
import tempfile

from neovim import attach

def get_nvim():
    addr = os.environ.get("NVIM_LISTEN_ADDRESS", None)
    if not addr:
        print ("Not running inside nvim.. exiting")
        sys.exit(1)

    nvim = attach("socket", path=addr)
    return nvim


def get_vim_pid(nvim):
    _, path = tempfile.mkstemp()
    pid=0
    try:
        command = 'silent execute "!echo " . getpid() . "> {}"'.format(path)
        nvim.command(command)
        with open(path, 'r') as fd:
            pid = int(fd.read().strip())
    finally:
        os.remove(path)
    return pid
