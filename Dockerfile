FROM ubuntu:22.04

RUN apt-get update \
	&& apt-get -y -q install build-essential git curl cmake psmisc linux-tools-generic \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# RUN python3 -m pip install scipy numpy matplotlib

# we need node21
RUN curl -sL https://deb.nodesource.com/setup_21.x | bash - \
	&& apt-get install -y nodejs

# Clone binaryen
RUN cd /home \
    && git clone https://github.com/WebAssembly/binaryen \
	&& cd binaryen && git submodule init && git submodule update \
	&& cmake . && make -j

# Clone virgil and wizard repository
RUN mkdir -p /home/titzer && cd /home/titzer \
    && git clone https://github.com/titzer/virgil \
	&& git clone https://github.com/titzer/wizard-engine \
	&& git clone https://github.com/composablesys/wish-you-were-fast \
	&& cd virgil && export PATH=$PATH:`pwd`/bin:`pwd`/bin/dev && make \
	&& cd ../wizard-engine && make -j \
	&& cd ../wish-you-were-fast/tools && make -j

RUN npm install jsvu -g && jsvu --os=linux64 --engines=javascriptcore,v8,spidermonkey
RUN curl https://wasmtime.dev/install.sh -sSf | bash
RUN curl https://get.wasmer.io -sSfL | sh

ENV PATH="/home/binaryen/bin:/home/titzer/wish-you-were-fast/tools/bin:/home/titzer/wish-you-were-fast/wasm:/home/titzer/virgil/bin/dev:/home/titzer/wizard-engine/bin:${PATH}"
ENV SM="/root/.jsvu/bin/sm"
ENV D8="/root/.jsvu/bin/v8"
ENV JSC="/root/.jsvu/bin/jsc"
ENV WIZENG="/home/titzer/wizard-engine/bin/wizeng.x86-64-linux"
ENV WASMTIME="/root/.wasmtime/bin/wasmtime"
ENV WASMER="/root/.wasmer/bin/wasmer"

ENV DISPLAY=":0"

# Copy the wasm-r3 repo 
RUN mkdir -p /home/wasm-r3 && cd /home/wasm-r3
COPY . /home/wasm-r3

# Install the dependencies
RUN cd /home/wasm-r3 && npm install && npx playwright install-deps && npx playwright install

WORKDIR /home/wasm-r3

CMD ["bash"]