#!/usr/bin/env python3

# https://stackoverflow.com/a/6098238/1548052
import os, sys, inspect
folder = os.path.realpath(os.path.abspath(os.path.split(inspect.getfile(inspect.currentframe()))[0]))
if folder not in sys.path:
    sys.path.insert(0, folder)
subfolder = os.path.realpath(os.path.abspath(os.path.join(os.path.split(inspect.getfile(inspect.currentframe()))[0], "..")))
if subfolder not in sys.path:
    sys.path.insert(0, subfolder)

from pum.core.deltapy import DeltaPy
from view.create_views import create_views


class CreateViews(DeltaPy):

    def run(self):
        create_views(srid=self.variable('SRID'))