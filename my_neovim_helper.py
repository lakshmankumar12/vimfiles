#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function
import os
import sys

from neovim import attach

def get_nvim():
    addr = os.environ.get("NVIM_LISTEN_ADDRESS", None)
    if not addr:
        print ("Not running inside nvim.. exiting")
        sys.exit(1)

    nvim = attach("socket", path=addr)
    return nvim

