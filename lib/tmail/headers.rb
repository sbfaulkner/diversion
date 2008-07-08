#
# add support for custom x-diverted-... headers in order to preserve the original recipients
#
module TMail
  DIVERTED_HEADERS=%w(to cc bcc)
  X_DIVERTED_HEADERS=DIVERTED_HEADERS.collect { |h| "x-diverted-#{h}" }
  
  # specify that the x-diverted-... headers specify an email address
  class HeaderField
    # indicate that the x-diverted-... headers are address headers
    X_DIVERTED_HEADERS.each { |h| FNAME_TO_CLASS[h] => AddressHeader }
  end
  
  class Mail
    # allow multiple values for the headers
    X_DIVERTED_HEADERS.each { |h| ALLOW_MULTIPLE[h] => true }

    X_DIVERTED_HEADERS.each do |h|
      h_name = h.underscore
      self.instance_eval <<-METHODS
        def #{h_name}_addrs(default = nil)
          if h = @header['#{h}']
            h.addrs
          else
            default
          end
        end
        
        def #{h_name}_addrs=(arg)
          set_addrfield '#{h}', arg
        end
        
        def #{h_name}(default = nil)
          addrs2specs(#{h_name}_addrs(nil)) || default
        end
        
        def #{h_name}=(*strs)
          set_string_array_attr '#{h.gsub(/\b([a-z])/) { |m| m.capitalize}}', strs
        end
      METHODS
    end
  end
end
