# Homebrew formula for Crafty
# by Lawrence Leonard Gilbert (13 Jul 2013)
# dedicated to the public domain
#
# TODO:
# * Test(s)
# * Install the opening-moves book
# * Install help
# * Determine number of cores and configure appropriately

require 'formula'

class Crafty < Formula
  homepage 'http://www.craftychess.com/'
  url 'http://www.craftychess.com/crafty-23.4.zip'
  sha1 '383079c0f99f133faa541d1949f6be4f67101f3f'

  def patches
    DATA
  end

  def install
    system 'make', 'darwin'
    bin.install 'crafty'
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test crafty`.
    system "false"
  end
end

__END__

diff -ru crafty-23.4.orig/chess.h crafty-23.4/chess.h
--- crafty-23.4.orig/chess.h	2010-11-08 10:07:43.000000000 -0800
+++ crafty-23.4/chess.h	2013-06-13 23:45:51.000000000 -0700
@@ -25,7 +25,7 @@
 #include <assert.h>
 #include <stdlib.h>
 #if !defined(IPHONE)
-#  include <malloc.h>
+#  include <malloc/malloc.h>
 #endif
 #include <string.h>
 #if !defined(TYPES_INCLUDED)
