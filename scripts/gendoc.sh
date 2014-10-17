#!/bin/bash

MATRIXDOTORG=$HOME/workspace/matrix.org

# list of places we mess with the template:
#
# docs/*/*.html
# mailman
# alpha
# swagger
# blog

cat ../specification/*.rst > /tmp/spec.rst
rst2html-2.7.py --stylesheet=basic.css,nature.css /tmp/spec.rst > $MATRIXDOTORG/docs/spec/index.html
rst2html-2.7.py --stylesheet=basic.css,nature.css ../howtos/client-server.rst > $MATRIXDOTORG/docs/howtos/client-server.html

perl -pi -e 's#<head>#<head><link rel="stylesheet" href="/site.css">#' $MATRIXDOTORG/docs/spec/index.html $MATRIXDOTORG/docs/howtos/client-server.html

perl -MFile::Slurp -pi -e 'BEGIN { $nav = read_file("'$MATRIXDOTORG'/includes/nav.html") } s#<body>#<body><div id="header"><div id="headerContent">$nav</div></div><div id="page"><div id="wrapper"><div style="text-align: center; padding: 40px;"><a href="/"><img src="/matrix.png" width="305" height="130" alt="[matrix]"/></a></div>#' $MATRIXDOTORG/docs/spec/index.html $MATRIXDOTORG/docs/howtos/client-server.html

perl -pi -e 's#</body>#</div></div><div id="footer"><div id="footerContent">&copy 2014 Matrix.org</div></div></body>#' $MATRIXDOTORG/docs/spec/index.html $MATRIXDOTORG/docs/howtos/client-server.html

scp -r $MATRIXDOTORG/docs matrix@ldc-prd-matrix-001:/sites/matrix