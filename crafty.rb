# Homebrew formula for Crafty
# by Lawrence Leonard Gilbert (13 Jul 2013)
# dedicated to the public domain
#
# TODO:
# * Install the opening-moves book
# * Install help
# * Determine number of cores and configure appropriately

require 'formula'

class Crafty < Formula
  # Look for newer versions at http://www.cis.uab.edu/hyatt/crafty/source/?C=M;O=D
  # because the home page may not be up-to-date
  homepage 'http://www.craftychess.com/'
  url 'http://www.cis.uab.edu/hyatt/crafty/source/crafty-23.8.zip'
  sha1 '662ae1f97727eacfae0cff0a8e6449a45178648d'

  def install
    system 'make', 'darwin'
    bin.install 'crafty'
  end

  test do
    system 'crafty end'
  end
end
