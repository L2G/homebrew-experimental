require 'formula'

class Pybitmessage < Formula
  GITHUB_URL = 'https://github.com/Bitmessage/PyBitmessage.git'

  homepage 'https://bitmessage.org/wiki/Main_Page'
  version '0.3.5'
  url GITHUB_URL, :revision => '97df9e04f13c8450e62d97f0fe50d1264f39488b'
  head GITHUB_URL

  depends_on :python
  depends_on 'pyqt'
  depends_on 'openssl'

  def install
    system 'make', "PREFIX=#{prefix}", 'install'
  end

  def caveats; <<-EOM
    Bitmessage is a very experimental messaging protocol and may always have
    undiscovered security issues.

    Known security issues:

    * 2013-08-22: several potential security issues including a broken proof of
      work function and potential private key leaks; full details are at
      http://secupost.net/446308138/bitmessage-security

    EOM
  end

# test do
#   # `test do` will create, run in and delete a temporary directory.
#   #
#   # This test will fail and we won't accept that! It's enough to just replace
#   # "false" with the main program this formula installs, but it'd be nice if you
#   # were more thorough. Run the test with `brew test pybitmessage`.
#   system "false"
# end
end
