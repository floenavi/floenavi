#!/bin/bash

pandoc -s -o README.html README.md
pandoc -s -o UPGRADE.html UPGRADE.md
pandoc -s -o FEATURES.html FEATURES.md
pandoc -s -o RELEASE-NOTES.html RELEASE-NOTES.md

pandoc -s -o README.pdf README.md
pandoc -s -o UPGRADE.pdf UPGRADE.md
pandoc -s -o FEATURES.pdf FEATURES.md
pandoc -s -o RELEASE-NOTES.pdf RELEASE-NOTES.md
