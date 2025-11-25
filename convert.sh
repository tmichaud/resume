#! /bin/bash

# Note: Requires libreoffice to be installed
# Note: Requires pandoc to be installed (sudo apt install pandoc)

libreoffice --headless --convert-to pdf --outdir .  ./Resume.docx
pandoc Resume.docx -t markdown --wrap=none  -o README.md
mv README.md README.tmp
cat README.tmp | ./c.pl > README.md
rm README.tmp
