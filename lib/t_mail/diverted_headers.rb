module TMail
  module DivertedHeaders
    DIVERTED_HEADERS=%w(to cc bcc)
    X_DIVERTED_HEADERS=DIVERTED_HEADERS.collect { |h| "x-diverted-#{h}" }

    def self.included(base)
      base.class_eval 'X_DIVERTED_HEADERS.each { |h| FNAME_TO_CLASS[h] = AddressHeader }', __FILE__, __LINE__
    end
  end
end
