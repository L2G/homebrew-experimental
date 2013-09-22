require 'formula'

class Musescore < Formula
  # The head revision is specified here so it can be injected into the code.
  # There is a makefile target that normally takes care of this, but it only
  # works correctly when make is run within the Git checkout.
  HEAD_REVISION = 'bd8b9024f68a85831a7606a332456f3b93acc8bd'

  homepage 'http://musescore.org/'
  head 'https://github.com/musescore/MuseScore.git', :revision => HEAD_REVISION

  depends_on 'cmake'
  depends_on 'git'
  depends_on 'jack'
  depends_on 'lame'
  depends_on 'libogg'
  depends_on 'libsndfile'
  depends_on 'libvorbis'
  depends_on 'pkg-config'
  depends_on 'portaudio'
  depends_on 'qt5'

  def install
    ENV.append 'LDFLAGS', '-L/usr/local/opt/qt5/lib'
    ENV.append 'CPPFLAGS', '-I/usr/local/opt/qt5/include'

    # This takes care of what 'make revision' would normally do
    inreplace 'mscore/revision.h', /^.......$/, HEAD_REVISION[0..6]

    system 'make -f Makefile.osx release'
    system 'make -f Makefile.osx install'

    bin.install 'applebuild/mscore.app'
  end

  def caveats
    %(This builds a full-fledged Mac Qt app. You may want to run "brew\n) +
    %(linkapps" after installation.)
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test musescore`.
    system "false"
  end
end
