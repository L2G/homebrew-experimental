require 'formula'

class Riak < Formula
  homepage 'http://basho.com/riak/'
  url 'http://s3.amazonaws.com/downloads.basho.com/riak/1.4/1.4.2/riak-1.4.2.tar.gz'
  sha256 '6a1fdcfc1f3f0357eeb377ead6638db4187379e3b40121cef16b517e03c6fd11'

  depends_on 'erlang-r15' # R16 is too new for 1.4.2

  def install
    ENV.deparallelize
    system 'make rel'

    prefix.install Dir['rel/riak/*']
    inreplace Dir["#{lib}/env.sh"] do |s|
      s.change_make_var! "RUNNER_BASE_DIR", prefix
    end
  end
end
