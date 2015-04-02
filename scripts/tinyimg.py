#!/usr/bin/env /usr/bin/python2

from os.path import dirname
from urllib2 import Request, urlopen
from base64 import b64encode
import sys
from shutil import move

key = "api:P0wjFRR0eD6ykXNq2SC9Izjd8mW8YOxA"
inputf = str(sys.argv[1])
old = "old-" + str(sys.argv[1])

request = Request("https://api.tinypng.com/shrink", open(inputf, "rb").read())

cafile = None
# Uncomment below if you have trouble validating our SSL certificate.
# Download cacert.pem from: http://curl.haxx.se/ca/cacert.pem
# cafile = dirname(__file__) + "/cacert.pem"

auth = b64encode(bytes(key.encode("ascii"))).decode("ascii")
request.add_header("Authorization", "Basic %s" % auth)

resp = urlopen(request)
if resp.getcode()  == 201:
  # Compression was successful, retrieve output from Location header.
  resu = urlopen(resp.info()["Location"]).read()
  move(inputf, old)
  open(inputf, "wb").write(resu)
else:
  # Something went wrong! You can parse the JSON body for details.
  print("Compression failed")
