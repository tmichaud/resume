#! /bin/bash

# Note: Requires libreoffice to be installed

libreoffice --headless --convert-to pdf  --outdir .  ./Resume.docx
libreoffice --headless --convert-to html --outdir .  ./Resume.docx && mv Resume.html README.md
