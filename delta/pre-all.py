#!/usr/bin/env python3

import sys, os
import psycopg2
sys.path.append(os.path.join(os.path.dirname(__file__), '..'))

from pum.core.deltapy import DeltaPy
from view.create_views import drop_views


class DropViews(DeltaPy):

    def run(self):
        drop_views(pg_service=self.pg_service)
