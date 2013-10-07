require 'formula'

class Terminator < Formula
  homepage 'https://launchpad.net/terminator/'
  url 'https://launchpad.net/terminator/trunk/0.97/+download/' \
      'terminator-0.97.tar.gz'
  sha256 '9131847023fa22f11cf812f6ceff51b5d66d140b6518ad41d7fa8b0742bfd3f7'
  head 'bzr://lp:terminator'

  depends_on :python
  depends_on 'bazaar' => :build if build.head?
  depends_on 'gettext' => :build
  depends_on 'intltool' => :build
  depends_on 'l2g/experimental/vte' => 'with-python'

  def install
    python { system python, "setup.py", "install", "--prefix=#{prefix}" }
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if
    # you were more thorough. Run the test with `brew test gnome-terminator`.
    system "false"
  end
end
