require 'formula'

class Bitcoin < Formula
  homepage 'http://bitcoin.org/'
  url 'https://github.com/bitcoin/bitcoin/archive/v0.8.6.tar.gz'
  sha1 '6947ef865e82f3952abc9fc2b112f6b15821bfe3'

  devel do
    version '0.9.0rc1'
    url 'https://github.com/bitcoin/bitcoin/archive/v0.9.0rc1.tar.gz'
    sha1 '68a6c0a0caf1c55e82733d27d8e28c7c2bb20d62'
  end

  head 'https://github.com/bitcoin/bitcoin.git'

  option 'with-qt', 'Also build the complete GUI app with Qt framework'

  depends_on :xcode
  depends_on :arch => :intel
  depends_on :autoconf => :build if build.head?
  depends_on 'pkg-config' => :build

  depends_on 'berkeley-db4'
  depends_on 'boost'
  depends_on 'miniupnpc'
  depends_on 'openssl'
  depends_on 'qt' => :optional
  depends_on 'protobuf' if (build.with? 'qt' or !build.stable?)

  def patches
    DATA if build.stable?
  end

  def install
    unless build.stable?
      # New GNU-style build. Yay!
      system './autogen.sh'
      system './configure', '--disable-debug',
                            '--disable-dependency-tracking',
                            "--prefix=#{prefix}"
      system 'make'
      system 'make', 'check'
      system 'make', 'install'

      if build.with? 'qt'
        system 'make', 'appbundle'
        prefix.install 'Bitcoin-Qt.app'
      end

    else
      system *%w( make -C src -f makefile.osx )
      system *%w( make -C src -f makefile.osx test )
      bin.install 'src/bitcoind'

      if build.with? 'qt'
        system 'qmake', 'bitcoin-qt.pro'
        system 'make'
        prefix.install 'Bitcoin-Qt.app'
      end
    end
  end

  test do
    if which('test_bitcoin')
      system 'test_bitcoin'
      system 'test_bitcoin-qt' if which('test_bitcoin-qt')
    else
      opoo 'Bitcoin tests were not built (0.8.x does not build self-tests)'
    end
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
