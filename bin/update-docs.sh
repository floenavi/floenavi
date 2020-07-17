#!/bin/bash

pandoc -s -o README.html README.md
pandoc -s -o UPGRADE.html UPGRADE.md
pandoc -s -o FEATURES.html FEATURES.md
pandoc -s -o RELEASE-NOTES.html RELEASE-NOTES.md
