#!/bin/bash

pandoc -s -o README.html README.md
pandoc -s -o UPGRADE.html UPGRADE.md
pandoc -s -o RELEASE_NOTES.html RELEASE_NOTES.md
