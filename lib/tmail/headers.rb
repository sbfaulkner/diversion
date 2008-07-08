module TMail
  class HeaderField
    FNAME_TO_CLASS.merge!(
      'x-diverted-to' => AddressHeader,
      'x-diverted-cc' => AddressHeader,
      'x-diverted-bcc' => AddressHeader
    )
  end
  
  class Mail
    ALLOW_MULTIPLE.merge!(
      'x-diverted-to' => true,
      'x-diverted-cc' => true,
      'x-diverted-bcc' => true
    )
    
    #
    # diversion
    #

    def x_diverted_to_addrs( default = nil )
      if h = @header['x-diverted-to']
        h.addrs
      else
        default
      end
    end

    def x_diverted_cc_addrs( default = nil )
      if h = @header['x-diverted-cc']
        h.addrs
      else
        default
      end
    end

    def x_diverted_bcc_addrs( default = nil )
      if h = @header['x-diverted-bcc']
        h.addrs
      else
        default
      end
    end

    def x_diverted_to_addrs=( arg )
      set_addrfield 'x-diverted-to', arg
    end

    def x_diverted_cc_addrs=( arg )
      set_addrfield 'x-diverted-cc', arg
    end

    def x_diverted_bcc_addrs=( arg )
      set_addrfield 'x-diverted-bcc', arg
    end

    def x_diverted_to( default = nil )
      addrs2specs(x_diverted_to_addrs(nil)) || default
    end

    def x_diverted_cc( default = nil )
      addrs2specs(x_diverted_cc_addrs(nil)) || default
    end

    def x_diverted_bcc( default = nil )
      addrs2specs(x_diverted_bcc_addrs(nil)) || default
    end

    def x_diverted_to=( *strs )
      set_string_array_attr 'X-Diverted-To', strs
    end

    def x_diverted_cc=( *strs )
      set_string_array_attr 'X-Diverted-Cc', strs
    end

    def x_diverted_bcc=( *strs )
      set_string_array_attr 'X-Diverted-Bcc', strs
    end
  end
end
