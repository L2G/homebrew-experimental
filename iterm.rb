require 'formula'

class Iterm < Formula
  homepage ''
  url 'https://github.com/gnachman/iTerm2/archive/v1.0.0.20131228.tar.gz'
  version '1.0.0.20131228'
  sha1 '36eaf9d38c20ffbb4c68502003933c05c3206b43'

  # depends_on 'cmake' => :build
  depends_on :x11 # if your formula requires any X11/XQuartz components

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system 'make', 'Deployment'
    prefix.install 'build/Deployment/iTerm.app'
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
