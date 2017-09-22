#! /usr/bin/env python

import os
import sys

output = sys.argv[1]
alist = sys.argv[2:]

with open(output, "w") as fh:
    for var in alist:
        fh.write(os.path.abspath(var)+"\n")



