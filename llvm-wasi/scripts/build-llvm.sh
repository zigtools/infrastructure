cd emsdk && . ./emsdk_env.sh
mkdir -p /build/llvm

# -DCMAKE_EXE_LINKER_FLAGS="-s STANDALONE_WASM -s WASM_BIGINT -s WASM=1" \
# -DLLVM_TARGET_ARCH=wasm32 \
# -DCMAKE_LIBRARY_ARCHITECTURE=wasm32-wasi \
# -DCMAKE_EXECUTABLE_SUFFIX=.wasm
    # -DCMAKE_EXE_LINKER_FLAGS="-s ASSERTIONS=1 -s ENVIRONMENT=\"'web,webview,worker,node'\" -s MODULARIZE=1 -s EXPORT_ES6=1 -s MAIN_MODULE=2 -s EXPORTED_FUNCTIONS=_main,_free,_malloc" \

CXXFLAGS="-Dwait4=__syscall_wait4" \
LDFLAGS="\
        -s ASSERTIONS \
        -s LLD_REPORT_UNDEFINED=1 \
        -s ALLOW_MEMORY_GROWTH=1 \
        -s EXPORTED_FUNCTIONS=_main,_free,_malloc \
        -s EXPORTED_RUNTIME_METHODS=FS,PROXYFS,ERRNO_CODES,allocateUTF8 \
        -lproxyfs.js \
        -static \
        --js-library=/emlib/fsroot.js \
" emcmake cmake -G "Ninja" \
    -S /upstream/llvm-project/llvm/ \
    -B /build/llvm/ \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_PROJECTS="lld;clang" \
    -DLLVM_ENABLE_DUMP=OFF \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_ENABLE_EXPENSIVE_CHECKS=OFF \
    -DLLVM_ENABLE_LIBXML2=OFF \
    -DLLVM_ENABLE_ZLIB=OFF \
    -DLLVM_ENABLE_BACKTRACES=OFF \
    -DLLVM_TARGETS_TO_BUILD="WebAssembly" \
    -DLLVM_BUILD_TOOLS=OFF \
    -DLLVM_BUILD_UTILS=OFF \
    -DCLANG_ENABLE_ARCMT=OFF \
    -DCLANG_ENABLE_STATIC_ANALYZER=OFF \
    -DLLVM_ENABLE_THREADS=OFF \
    -DLLVM_BUILD_LLVM_DYLIB=OFF \
    -DLLVM_INCLUDE_TESTS=OFF \
    -DLLVM_INCLUDE_EXAMPLES=OFF \
    -DLLVM_INCLUDE_BENCHMARKS=OFF \
    -DLLVM_ENABLE_BINDINGS=ON \
    -DLLVM_ENABLE_OCAMLDOC=OFF \
    -DLLVM_ENABLE_Z3_SOLVER=OFF \
    -DLLVM_ENABLE_TERMINFO=0 \
    -DLLVM_TABLEGEN=/build/llvm-native/bin/llvm-tblgen \
    -DCLANG_TABLEGEN=/build/llvm-native/bin/clang-tblgen \
    -DLLVM_BUILD_STATIC=ON \
    -DLLVM_ENABLE_PIC=OFF \
    -DCMAKE_CXX_FLAGS_RELEASE="-O1"

cmake --build /build/llvm/ -- clang lld
