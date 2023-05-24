# Cross compiling llvm needs a native build of "llvm-tblgen" and "clang-tblgen"
cmake -G Ninja \
    -S /upstream/llvm-project/llvm/ \
    -B "/build/llvm-native" \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_TARGETS_TO_BUILD=WebAssembly \
    -DLLVM_ENABLE_PROJECTS="clang"

cmake --build "/build/llvm-native" -- llvm-tblgen clang-tblgen
