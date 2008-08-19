module TMail
  module DivertedAccessors
    def self.included(base)
      base.extend ClassMethods
      base.send :define_diverted_accessors
    end
    
    module ClassMethods
      def define_diverted_accessors
        TMail::DivertedHeaders::X_DIVERTED_HEADERS.each do |h|
          # allow multiple values for the header
          TMail::Mail::ALLOW_MULTIPLE[h] = true
          h_name = h.underscore
          # define accessors for reading and writing headers
          define_addrs_read_method(h_name, h)
          define_addrs_write_method(h_name, h)
          define_read_method(h_name)
          define_write_method(h_name, h)
        end
      end
      
      def define_addrs_read_method(fname, hname)
        class_eval "def #{fname}_addrs(default = nil); h = @header['#{hname}']; h ? h.addrs : default; end", __FILE__, __LINE__
      end
      
      def define_addrs_write_method(fname, hname)
        class_eval "def #{fname}_addrs=(arg); set_addrfield '#{hname}', arg; end", __FILE__, __LINE__
      end
      
      def define_read_method(fname)
        class_eval "def #{fname}(default = nil); addrs2specs(#{fname}_addrs(nil)) || default; end", __FILE__, __LINE__
      end
      
      def define_write_method(fname, hname)
        class_eval "def #{fname}=(*strs); set_string_array_attr '#{hname.gsub(/\b([a-z])/) { |m| m.capitalize}}', strs; end", __FILE__, __LINE__
      end
    end
  end
end
