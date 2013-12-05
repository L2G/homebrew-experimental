require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class R < Formula
  homepage 'http://www.r-project.org/'
  url 'http://ftp.osuosl.org/pub/cran/src/base/R-3/R-3.0.2.tar.gz'
  sha1 'f5d9daef00e09d36a465ff7b0bf4cab136bea227'

  depends_on :x11 => :recommended
  depends_on :cairo => :recommended
  depends_on :fortran
  depends_on 'pkg-config' => :build

  def install
    config_options = %W[
      --without-recommended-packages
      --disable-R-framework
      --prefix=#{prefix}
    ]

    # Options that can be passed through to configure, verbatim
    %w[ without-cairo ].each do |opt|
      config_options.unshift("--#{opt}") if build.include?(opt)
    end

    # Other options that have to be massaged
    config_options.unshift('--without-x') if build.without?(:x11)

    system './configure', *config_options
    system 'make'
    system 'make', 'install'
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test R`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "--version"`.
    system "false"
  end
end
