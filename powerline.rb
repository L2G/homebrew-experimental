require 'formula'

class Powerline < Formula
  homepage 'https://github.com/Lokaltog/powerline'
  head do
    url 'https://github.com/Lokaltog/powerline.git'
    sha1 'fa18fc859ca9a3d0835f0c6790815e6c097c1add'
  end

  depends_on :python
  depends_on :python3 => :optional

  def install
    system python, "setup.py", "install", "--prefix=#{prefix}",
                                          "--single-version-externally-managed",
                                          "--record=installed.txt"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test powerline`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "--version"`.
    system "false"
  end
end
