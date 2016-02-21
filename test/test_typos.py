import unittest

import os
import glob

class TestTypos(unittest.TestCase):

    def test_dammage(self):
        thisdir = os.path.dirname(os.path.realpath(__file__))
        for filename in glob.glob(os.path.join(thisdir, '..', '*.sql')):
            with open(os.path.join(os.getcwd(), '..', filename), 'r') as f:
                for line in f:
                    self.assertNotIn('dammage', line)

if __name__ == '__main__':
    unittest.main()
