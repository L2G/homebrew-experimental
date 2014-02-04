require 'formula'

class Powerline < Formula
  homepage 'https://github.com/Lokaltog/powerline'
  head 'https://github.com/Lokaltog/powerline.git'

  depends_on :python3 => :optional

  def install
    system (build.with?('python3') ? 'python3' : 'python'),
           "setup.py", "install",
                         "--prefix=#{prefix}",
                         "--single-version-externally-managed",
                         "--record=installed.txt"
  end

  test do
    %w(powerline powerline-lint).each do |pgm|
      exec_this = "#{bin}/#{pgm}"
      ohai exec_this
      assert_match(/^usage: #{pgm} \[-h\]/, `#{exec_this} -h`)
    end
  end
end
