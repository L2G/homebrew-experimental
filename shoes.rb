require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Shoes < Formula
  homepage 'http://www.shoesrb.com/'
  head 'https://github.com/shoes/shoes.git'

  # depends_on 'cmake' => :build
  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on 'ruby' => :build

  # These dependencies are taken from make/darwin/homebrew.rb in the Shoes
  # source

  depends_on :cairo
  depends_on 'pango'
  depends_on 'gettext'
  depends_on 'glib'
  depends_on 'pixman'
  depends_on 'jpeg'
  depends_on 'giflib'
  depends_on 'portaudio'

  def install
    system 'rake'
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test shoes`.
    system "false"
  end
end
