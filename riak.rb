require 'formula'

class Riak < Formula
  homepage 'http://basho.com/riak/'
  url 'http://s3.amazonaws.com/downloads.basho.com/riak/1.4/1.4.2/riak-1.4.2.tar.gz'
  sha256 '6a1fdcfc1f3f0357eeb377ead6638db4187379e3b40121cef16b517e03c6fd11'

  depends_on 'erlang-r15' # R16 is too new for 1.4.2

  # Constants for use in this formula's plist
  SOFT_FILE_LIMIT = 4096
  START_CMD       = %w( /usr/local/bin/riak start )

  plist_options :manual => START_CMD.join(' ')

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
          #{START_CMD.map { |s| "<string>#{s}</string>" }}
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
