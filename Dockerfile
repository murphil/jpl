FROM fj0rd/jpl:hs

# RUN set -ex \
#   ; jupyter labextension install jupyterlab-ihaskell \
#   ; rm -rf /usr/local/share/.cache/yarn

# ### iLua
# RUN set -ex \
#   ; apt-get update \
#   ; apt-get install -y --no-install-recommends \
#       lua5.3 luarocks lua-dkjson \
#   ; apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
#   ; cd /usr/bin && ln -fsr lua5.3 lua \
#   ; cd ${HOME} \
#   ; git clone https://github.com/guysv/ilua.git --recurse-submodules \
#   ; cd ilua \
#   ; pip --no-cache-dir install -e . --user \
#   ; python setup.py install_data -d ${HOME}/.local \
#   ; rm -rf ${HOME}/ilua/.git


COPY examples/* ./examples/

### misc
#RUN set -ex \
#  ; stack install flow \
#  ; stack repl

# ENTRYPOINT [ "/usr/bin/tini", "--" ]
# CMD [ "jupyter", "lab", "--ip", "0.0.0.0"]
