if [ ! -d "/upstream/llvm-project" ]; then
    wget https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.0/llvm-project-16.0.0.src.tar.xz
    mkdir -p /upstream/llvm-project
    tar -xf llvm-project-16.0.0.src.tar.xz --directory /upstream/llvm-project --strip-components=1

    cd /upstream/llvm-project
    patch -p1 /patches/llvm.patch
fi
