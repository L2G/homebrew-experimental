require 'formula'

class Riak < Formula
  homepage 'http://basho.com/riak/'
  url 'http://s3.amazonaws.com/downloads.basho.com/riak/1.4/1.4.2/riak-1.4.2.tar.gz'
  sha256 '6a1fdcfc1f3f0357eeb377ead6638db4187379e3b40121cef16b517e03c6fd11'

  devel do
    url 'http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.0pre5/' \
          'riak-2.0.0pre5.tar.gz'
    sha256 'fcb21597251ca0c1fea368a6709c34f5f900b0c4c292be5388fddfc5c310d367'
    version '2.0.0-pre5'
  end

  head 'https://github.com/basho/riak.git', :branch => 'develop'

  if build.devel? || build.head?
    depends_on 'erlang'
    depends_on 'solr'
  else
    depends_on 'erlang-r15' # R16 is too new for 1.4.2
  end

  # Constants for use in this formula's plist
  SOFT_FILE_LIMIT = 4096

  plist_options :manual => 'riak start'

  def install
    ENV.deparallelize
    system 'make rel'

    prefix.install Dir['rel/riak/*']
    inreplace Dir["#{lib}/env.sh"] do |s|
      s.change_make_var! "RUNNER_BASE_DIR", prefix
    end
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd" >
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_prefix}/bin/riak</string>
          <string>start</string>
        </array>
        <key>SoftResourceLimits</key>
        <dict>
          <key>NumberOfFiles</key>
          <integer>#{SOFT_FILE_LIMIT}</integer>
        </dict>
      </dict>
    </plist>
    EOS
  end

end
