require 'formula'

class Vte < Formula
  homepage 'http://developer.gnome.org/vte/'
  url 'http://ftp.gnome.org/pub/gnome/sources/vte/0.28/vte-0.28.0.tar.bz2'
  sha1 '49b66a0346da09c72f59e5c544cc5b50e7de9bc1'

  option 'with-python', 'Build with Python bindings'

  if build.with? 'python'
    depends_on :python
    depends_on 'pygobject'
    depends_on 'pygtk'
  end
  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext'
  depends_on 'glib'
  depends_on 'gtk+'

  def patches
    DATA
  end

  def install
    configure_args = [ "--disable-dependency-tracking",
                       "--prefix=#{prefix}",
                       "--disable-Bsymbolic" ]
    configure_args << '--disable-python' unless build.with? 'python'
    system "./configure", *configure_args
    system "make install"
  end
end
__END__
diff --git a/configure b/configure
index 4bd81c1..0af4293 100755
--- a/configure
+++ b/configure
@@ -14063,8 +14063,8 @@ $as_echo "yes" >&6; }
 	:
 fi
 
-		# Extract the first word of "pygtk-codegen-2.0", so it can be a program name with args.
-set dummy pygtk-codegen-2.0; ac_word=$2
+		# Extract the first word of "pygobject-codegen-2.0", so it can be a program name with args.
+set dummy pygobject-codegen-2.0; ac_word=$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
 if test "${ac_cv_path_PYGTK_CODEGEN+set}" = set; then :
@@ -14105,7 +14105,7 @@ fi
 
 
 		if test "x$PYGTK_CODEGEN" = xno; then
-		  as_fn_error "could not find pygtk-codegen-2.0 script" "$LINENO" 5
+		  as_fn_error "could not find pygobject-codegen-2.0 script" "$LINENO" 5
 		fi
 
 		{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for pygtk defs" >&5
diff --git a/configure.in b/configure.in
index 3461bee..3c30bb7 100644
--- a/configure.in
+++ b/configure.in
@@ -492,9 +492,9 @@ if $BUILD_PYTHON ; then
 		AC_MSG_RESULT([found])
 		PKG_CHECK_MODULES(PYGTK,[pygtk-2.0])
 
-		AC_PATH_PROG(PYGTK_CODEGEN, pygtk-codegen-2.0, no)
+		AC_PATH_PROG(PYGTK_CODEGEN, pygobject-codegen-2.0, no)
 		if test "x$PYGTK_CODEGEN" = xno; then
-		  AC_MSG_ERROR(could not find pygtk-codegen-2.0 script)
+		  AC_MSG_ERROR(could not find pygobject-codegen-2.0 script)
 		fi
 
 		AC_MSG_CHECKING(for pygtk defs)
