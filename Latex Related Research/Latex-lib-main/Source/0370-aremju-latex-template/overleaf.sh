#!/bin/bash
ZIP_NAME="overleaf.zip"
rm -f "$ZIP_NAME"
zip -r "$ZIP_NAME" . -x "out/*" ".git/*" "" ".gitignore" "README.md" ".commitlintrc.json" "overleaf.sh" "LICENSE.md" "compile.sh"

