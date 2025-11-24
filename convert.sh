#! /bin/bash

# Note: Requires libreoffice to be installed
# Note: Requires pandoc to be installed (sudo apt install pandoc)

libreoffice --headless --convert-to pdf --outdir .  ./Resume.docx
pandoc Resume.docx -o README.md
