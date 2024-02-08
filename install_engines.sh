#!/bin/bash

# Install v8, jsc, sm
npm install jsvu -g
jsvu
jsvu javascriptcore@271958
ln -s ~/.jsvu/bin/javascriptcore-271958 ~/.jsvu/bin/jsc
echo 'export PATH="~/.jsvu/bin:${PATH}"' >> ~/.profile

# Install wasmtime
echo "Installing wasmtime..."
curl https://wasmtime.dev/install.sh -sSf | bash

# Install wasmer
echo "Installing wasmer..."
curl https://get.wasmer.io -sSfL | sh

echo "Installation completed."