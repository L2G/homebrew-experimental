require 'formula'

class Pybitmessage < Formula
  GITHUB_URL = 'https://github.com/Bitmessage/PyBitmessage.git'

  homepage 'https://bitmessage.org/wiki/Main_Page'
  version '0.3.5'
  url GITHUB_URL, :revision => '97df9e04f13c8450e62d97f0fe50d1264f39488b'
  head GITHUB_URL

  option 'with-gevent', 'Also install gevent via pip (depends on libevent)'

  depends_on :python => '2.7.5'
  depends_on 'pyqt'
  depends_on 'openssl'
  depends_on 'libevent' if build.with? 'gevent'

  def install
    system 'make', "PREFIX=#{prefix}", 'install'
    if build.with? 'gevent'
      python { system 'pip', 'install', 'gevent' }
    end
  end

  def caveats; <<-EOM
    Bitmessage is a very experimental messaging protocol and may have
    undiscovered security issues.
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
