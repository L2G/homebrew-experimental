require 'formula'

class Iterm2 < Formula
  homepage 'http://iterm2.com/'

  url 'https://github.com/gnachman/iTerm2/archive/v1.0.0.20140112.tar.gz'
  sha1 'ac60c6fd9e0c456229113c615f89b494bfd09458'

  head 'https://github.com/gnachman/iTerm2.git'

  conflicts_with 'iterm', :because => 'This supersedes the "iterm" brew.'

  depends_on :macos => (build.head? ? :mountain_lion : :snow_leopard)
  depends_on :xcode
  depends_on :x11

  def install
    system 'make', 'Deployment'
    prefix.install 'build/Deployment/iTerm.app'
  end

  def caveats
    <<-EOS.undent
      HEAD builds are known to fail. If you can fix it, please fork and file a
      pull request!
    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test iterm`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "--version"`.
    system "false"
  end
end
