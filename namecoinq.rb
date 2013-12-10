require 'formula'

class Namecoinq < Formula
  homepage 'http://namecoin.info/'
  url 'https://github.com/namecoinq/namecoinq/archive/vQ.3.72.tar.gz'
  version 'Q.3.72'
  sha1 'a071eaf250d015e58b8bf0886e8a3655fd70f18d'

  head 'https://github.com/namecoinq/namecoinq.git'

  depends_on :xcode
  depends_on :arch => :intel

  depends_on 'berkeley-db4'
  depends_on 'boost'
  depends_on 'miniupnpc'
  depends_on 'openssl'
  depends_on 'qt'
  depends_on 'protobuf'

  fails_with :clang do
    build 425
    cause 'Compilation failures in CryptoPP'
  end

  def patches
    DATA
  end

  def install
    ENV.deparallelize
    system 'qmake', 'namecoin-qt.pro'
    system 'make'
    prefix.install 'Namecoin-Qt.app'
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test vQ`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "--version"`.
    system "false"
  end
end

__END__
--- ./namecoin-qt.pro.orig  2013-10-29 06:38:10.000000000 -0700
+++ ./namecoin-qt.pro 2013-12-09 19:49:18.000000000 -0800
@@ -298,7 +298,7 @@
 }
 
 isEmpty(BDB_LIB_PATH) {
-    macx:BDB_LIB_PATH = /opt/local/lib/db48
+    macx:BDB_LIB_PATH = /usr/local/opt/berkeley-db4/lib
 }
 
 isEmpty(BDB_LIB_SUFFIX) {
@@ -306,15 +306,15 @@
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
 
 win32:DEFINES += WIN32 __WXMSW__ __NO_SYSTEM_INCLUDES
