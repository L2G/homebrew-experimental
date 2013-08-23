require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Bitcoin < Formula
  homepage 'http://www.bitcoin.org/'
  url 'https://github.com/bitcoin/bitcoin/archive/v0.8.3.tar.gz'
  sha1 '95060faee242f3ff6d1e91fd302c89e6f67cf1b1'
  devel do
    version '0.8.4rc2'
    url 'https://github.com/bitcoin/bitcoin/archive/v0.8.4rc2.tar.gz'
    sha1 '43a9f42e6153dfa83ece0f01742349233c5f79b7'
  end
  head 'https://github.com/bitcoin/bitcoin.git'

  #option 'with-qt', 'Build the complete GUI app with Qt framework'

  depends_on :xcode
  depends_on :arch => :intel

  depends_on 'berkeley-db4'
  depends_on 'boost'
  depends_on 'miniupnpc'
  depends_on 'openssl'
  #depends_on 'qt' => :optional

  def patches
    if build.head?
      { :p1 => [
          'contrib/homebrew/bitcoin.qt.pro.patch',
          'contrib/homebrew/makefile.osx.patch'
        ]
      }
    else
      # Tagged releases all seem to have broken OS X patches included, so
      # they have been reworked for this formula.
      DATA
    end
  end

  def install
    system *%w( make -C src -f makefile.osx )  
    system *%w( make -C src -f makefile.osx test )

    bin.install 'src/bitcoind'
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test bitcoin`.
    system "false"
  end
end

__END__
diff --git a/bitcoin-qt.pro b/bitcoin-qt.pro
index 05de051..8d1ce70 100644
--- a/bitcoin-qt.pro
+++ b/bitcoin-qt.pro
@@ -352,7 +352,7 @@ isEmpty(BOOST_THREAD_LIB_SUFFIX) {
 }
 
 isEmpty(BDB_LIB_PATH) {
-    macx:BDB_LIB_PATH = /opt/local/lib/db48
+    macx:BDB_LIB_PATH = /usr/local/opt/berkeley-db4/lib
 }
 
 isEmpty(BDB_LIB_SUFFIX) {
@@ -360,15 +360,15 @@ isEmpty(BDB_LIB_SUFFIX) {
 }
 
 isEmpty(BDB_INCLUDE_PATH) {
-    macx:BDB_INCLUDE_PATH = /opt/local/include/db48
+    macx:BDB_INCLUDE_PATH = /usr/local/opt/berkeley-db4/include
 }
 
 isEmpty(BOOST_LIB_PATH) {
-    macx:BOOST_LIB_PATH = /opt/local/lib
+    macx:BOOST_LIB_PATH = /usr/local/opt/boost/lib
 }
 
 isEmpty(BOOST_INCLUDE_PATH) {
-    macx:BOOST_INCLUDE_PATH = /opt/local/include
+    macx:BOOST_INCLUDE_PATH = /usr/local/opt/boost/include
 }
 
 win32:DEFINES += WIN32
diff --git a/src/makefile.osx b/src/makefile.osx
index 50279fd..7999161 100644
--- a/src/makefile.osx
+++ b/src/makefile.osx
@@ -7,17 +7,21 @@
 # Originally by Laszlo Hanyecz (solar@heliacal.net)
 
 CXX=llvm-g++
-DEPSDIR=/opt/local
+DEPSDIR=/usr/local
+DB4DIR=/usr/local/opt/berkeley-db4
+OPENSSLDIR=/usr/local/opt/openssl
 
 INCLUDEPATHS= \
  -I"$(CURDIR)" \
- -I"$(CURDIR)"/obj \
+ -I"$(CURDIR)/obj" \
  -I"$(DEPSDIR)/include" \
- -I"$(DEPSDIR)/include/db48"
+ -I"$(DB4DIR)/include" \
+ -I"$(OPENSSLDIR)/include"
 
 LIBPATHS= \
  -L"$(DEPSDIR)/lib" \
- -L"$(DEPSDIR)/lib/db48"
+ -L"$(DB4DIR)/lib" \
+ -L"$(OPENSSLDIR)/lib"
 
 USE_UPNP:=1
 USE_IPV6:=1
@@ -31,14 +35,14 @@ ifdef STATIC
 TESTLIBS += \
  $(DEPSDIR)/lib/libboost_unit_test_framework-mt.a
 LIBS += \
- $(DEPSDIR)/lib/db48/libdb_cxx-4.8.a \
+ $(DB4DIR)/lib/libdb_cxx-4.8.a \
  $(DEPSDIR)/lib/libboost_system-mt.a \
  $(DEPSDIR)/lib/libboost_filesystem-mt.a \
  $(DEPSDIR)/lib/libboost_program_options-mt.a \
  $(DEPSDIR)/lib/libboost_thread-mt.a \
  $(DEPSDIR)/lib/libboost_chrono-mt.a \
- $(DEPSDIR)/lib/libssl.a \
- $(DEPSDIR)/lib/libcrypto.a \
+ $(OPENSSLDIR)/lib/libssl.a \
+ $(OPENSSLDIR)/lib/libcrypto.a \
  -lz
 else
 TESTLIBS += \
