class Caffe < Formula
  desc "A fast open framework for deep learning"
  homepage "http://caffe.berkeleyvision.org/"
  head "https://github.com/BVLC/caffe.git"

  # Build deps
  depends_on "cmake" => :build

  # Core deps
  depends_on "boost-python"
  depends_on "gflags"
  depends_on "glog"
  depends_on "leveldb"
  depends_on "lmdb"
  depends_on "snappy"

  # homebrew/python deps
  depends_on "homebrew/python/numpy"

  # homebrew/science deps
  depends_on "homebrew/science/hdf5"
  depends_on "homebrew/science/opencv3"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "false"
  end
end
