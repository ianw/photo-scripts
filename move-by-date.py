#!/usr/bin/env python

# Read the date from the EXIF tags of a bunch of photos, and move
# those that fall within a given date-range into a separate location.

import argparse
import glob
import logging
import os
import shutil

from datetime import datetime
from PIL import Image

def get_date_taken(f):
    s = Image.open(f)._getexif()[36867]
    return datetime.strptime(s, "%Y:%m:%d %H:%M:%S")

def valid_date(s):
    try:
        return datetime.strptime(s, "%Y-%m-%d")
    except ValueError:
        raise argparse.ArgumentError(
            "Not valid date: '{0}'.".format(s))

def valid_dir(s):
    if not os.path.isdir(s):
        raise argparse.ArgumentError("Not a valid output directory")
    else:
        return s

parser = argparse.ArgumentParser("Move JPG files to a directory based on date range")
parser.add_argument("--debug", action="store_true")
parser.add_argument("dest", help="Destination directory", type=valid_dir)
parser.add_argument("start", help="Start date (YYYY-MM-DD)", type=valid_date)
parser.add_argument("end", help="End date (YYYY-MM-DD)", type=valid_date)

args = parser.parse_args()

logging.basicConfig(
    level = logging.DEBUG if args.debug else logging.INFO)

# From midnight of the start day up until midnight of the end day
args.end = args.end.replace(hour=23,minute=59,second=59)

logging.debug("Moving files between %s and %s" %
              (args.start, args.end))

files = glob.glob('*.JPG')

for f in files:
    photo_date = get_date_taken(f)
    logging.debug("Processing %s (%s)" % (f, photo_date))

    if photo_date >= args.start and photo_date <= args.end:
        logging.info("Moving %s" % f)
        shutil.move(f, args.dest)

