require 'formula'

class Iterm < Formula
  homepage 'http://iterm2.com/'
  url 'file:'
  version '999'
  sha1 '36eaf9d38c20ffbb4c68502003933c05c3206b43'

  OBSOLESCENCE_MESSAGE = <<-END.undent
    The iterm formula is obsolete; please use iterm2 instead.
  END
    
  conflicts_with 'iterm2', :because => OBSOLESCENCE_MESSAGE

  def install
    opoo OBSOLESCENCE MESSAGE
  end

  def caveats
    OBSOLESCENCE_MESSAGE
  end
end
