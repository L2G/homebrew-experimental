# Homebrew formula for Crafty
# by Lawrence Leonard Gilbert (13 Jul 2013)
# dedicated to the public domain
#
# To do:
# * Install help
# * Determine number of cores and configure appropriately

class Crafty < Formula
  # Look for newer versions at http://www.cis.uab.edu/hyatt/crafty/source/?C=M;O=D
  # because the home page may not be up-to-date
  desc "A mature, high-performance chess engine; can be used alone or with Xboard"
  homepage "http://www.craftychess.com/"
  url "http://www.cis.uab.edu/hyatt/crafty/source/crafty-24.1.zip"
  sha256 "a29d25d9a26a5a958f07a075d1f76f52c12d287ad16ee7aadb224a0dfee40659"

  resource "opening-book" do
    url "http://www.craftychess.com/book.bin"
    sha256 "68790e80e1e7a6a755cfacdbe58a0bbc546a73dfb78a7d570aae133de3180ec9"
  end

  def book_dir
    share/"crafty"
  end

  def install
    inreplace "Makefile", /\topt='/, "\topt='-DBOOKDIR=\"\\\"#{book_dir}\\\"\" "
    system "make", "quick"
    bin.install "crafty"
    resource("opening-book").stage do
      mkdir_p book_dir
      book_dir.install "book.bin"
    end
  end

  test do
    system "crafty", "end"
  end

  def caveats; <<-EOS.undent
    Do not be alarmed by warnings about a missing file named "books.bin" (plural
    "books").
    EOS
  end
end
