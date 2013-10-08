require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class NotifyPython < Formula
  homepage ''
  url 'http://www.galago-project.org/files/releases/source/notify-python/notify-python-0.1.1.tar.bz2'
  sha1 '490693cf601793f50cef1a3c82ba75025497fc00'

  depends_on :python
  depends_on 'pkg-config' => :build
  depends_on 'pygtk'
  depends_on 'pygobject'
  depends_on 'libnotify'

  def install
    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  def caveats; <<-EOM.undent
    This formula is still in development, and #{name} itself has not been
    updated for years.  The software may not work properly even if it appears to
    be installed successfully.
    EOM
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test notify-python`.
    system "false"
  end
end
