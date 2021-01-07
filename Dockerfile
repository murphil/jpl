FROM nnurphy/jpl-hs

### iLua
RUN set -ex \
  ; apt-get update \
  ; apt-get install -y --no-install-recommends \
      lua5.3 luarocks lua-dkjson \
  ; apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
  ; cd /usr/bin && ln -fsr lua5.3 lua \
  ; cd ${HOME} \
  ; git clone https://github.com/guysv/ilua.git --recurse-submodules \
  ; cd ilua \
  ; pip --no-cache-dir install -e . --user \
  ; python setup.py install_data -d ${HOME}/.local \
  ; rm -rf ${HOME}/ilua/.git

### Julia
ENV JULIA_HOME=/opt/julia
ENV PATH=${JULIA_HOME}/bin:$PATH
RUN set -eux \
  ; mkdir -p ${JULIA_HOME} \
  ; julia_version=$(curl -sSL https://julialang.org/downloads/ | pup '#current_stable_release > a text{}' | awk '{print $4}') \
  ; julia_version_n=${julia_version:1} julia_version_m=${julia_version_n%.*} \
  ; curl https://julialang-s3.julialang.org/bin/linux/x64/${julia_version_m}/julia-${julia_version_n}-linux-x86_64.tar.gz \
    | tar xz -C ${JULIA_HOME} --strip-components 1 \
  ; julia -e 'using Pkg; Pkg.add("IJulia"); using IJulia'

COPY examples/* ./examples/

### misc
#RUN set -ex \
#  ; stack install flow \
#  ; stack repl

# ENTRYPOINT [ "/usr/bin/tini", "--" ]
# CMD [ "jupyter", "lab", "--ip", "0.0.0.0"]
