# Victor Costan's proposed, very complete formula for Caffe
# https://raw.githubusercontent.com/pwnall/homebrew-science/0a0ce36d94ada675e6b4cd1e4d1e4c6288638565/caffe.rb
# https://github.com/Homebrew/homebrew-science/pull/2402

class CudaRequirement < Requirement
  build true
  fatal true

  satisfy { which "nvcc" }

  cask "cuda"

  env do
    # Nvidia CUDA installs (externally) into this dir (hard-coded):
    ENV.append "CFLAGS", "-F/Library/Frameworks"
    # # because nvcc has to be used
    ENV.append "PATH", which("nvcc").dirname, ":"
  end

  def message
    <<-EOS.undent
      To use this formula with NVIDIA graphics cards you will need to
      download and install the CUDA drivers and tools from nvidia.com.

          https://developer.nvidia.com/cuda-downloads

      Select "Mac OS" as the Operating System and then select the
      "Developer Drivers for MacOS" package.
      You will also need to download and install the "CUDA Toolkit" package.

      The `nvcc` has to be in your PATH then (which is normally the case).

  EOS
  end
end

class Caffe < Formula
  desc "A deep learning framework"
  homepage "http://caffe.berkeleyvision.org/"
  url "https://github.com/BVLC/caffe/archive/rc2.tar.gz"
  version "rc2"
  sha256 "55c9c20870b30ce398e19e4f1a62ade1eff08fce51e28fa5604035b711978eec"

  head "https://github.com/BVLC/caffe.git"

  option "with-openblas", "Use OpenBLAS instead of Accelerate"
  option "with-cudnn", "Build with cuDNN support"
  option :cxx11

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "gflags"
  depends_on "glog"
  depends_on "hdf5"
  depends_on "leveldb"
  depends_on "lmdb"
  depends_on "openblas" => :optional
  depends_on CudaRequirement => :optional
  depends_on "opencv"
  depends_on "protobuf"
  depends_on "snappy"
  depends_on "szip"

  def install
    ENV.cxx11 if build.cxx11?

    args = std_cmake_args
    args << "-DBLAS=open" if build.with?("openblas")
    if build.with?("cudnn")
      args << "-DUSE_CUDNN=1"
    else
      args << "-DCPU_ONLY=1"
    end

    if ENV.compiler == :clang && !build.bottle?
      args << "-DENABLE_SSSE3=ON" if Hardware::CPU.ssse3?
      args << "-DENABLE_SSE41=ON" if Hardware::CPU.sse4?
      args << "-DENABLE_SSE42=ON" if Hardware::CPU.sse4_2?
      args << "-DENABLE_AVX=ON" if Hardware::CPU.avx?
    end

    mkdir "macbuild" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    system bin/"caffe"
  end
end
