FROM nnurphy/jpl-lua

RUN set -ex \
  #; jupyter labextension install ihaskell_labextension \
  ; jupyter labextension install ihaskell_jupyterlab \
  ; rm -rf /usr/local/share/.cache/yarn \
  ; stack install flow
