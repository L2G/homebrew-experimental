# Homebrew formula for Crafty
# by Lawrence Leonard Gilbert (13 Jul 2013)
# dedicated to the public domain
#
# To do:
# * Install the opening-moves book
# * Install help
# * Determine number of cores and configure appropriately

class Crafty < Formula
  # Look for newer versions at http://www.cis.uab.edu/hyatt/crafty/source/?C=M;O=D
  # because the home page may not be up-to-date
  homepage "http://www.craftychess.com/"
  url "http://www.cis.uab.edu/hyatt/crafty/source/crafty-24.1.zip"
  sha256 "a29d25d9a26a5a958f07a075d1f76f52c12d287ad16ee7aadb224a0dfee40659"

  def install
    system "make", "quick"
    bin.install "crafty"
  end

  test do
    system "crafty", "end"
  end
end
