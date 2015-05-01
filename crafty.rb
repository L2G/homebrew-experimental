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
  url "http://www.cis.uab.edu/hyatt/crafty/source/crafty-23.8.zip"
  sha256 "01c3c34125e43dcdba9015d8b31f0e2c46a58d792e8eefc0b75ca3ec6b294e14"

  def install
    system "make", "darwin"
    bin.install "crafty"
  end

  test do
    system "crafty", "end"
  end
end
