module ActionMailer
  module Diversion
    def self.included(base)
      base.class_eval do
        cattr_accessor :divert_to
        alias_method_chain :deliver!, :diversion
      end
    end
    
    def deliver_with_diversion!(mail = @mail)
      if divert_to
        logger.info "Modifying mail headers for diversion to: #{divert_to.inspect}" unless logger.nil?
        
        # save existing headers
        mail.x_diverted_to = mail.to unless mail.to.nil?
        mail.x_diverted_cc = mail.cc unless mail.cc.nil?
        mail.x_diverted_bcc = mail.bcc unless mail.bcc.nil?
        
        # re-address the message
        mail.to = quote_address_if_necessary([divert_to].flatten, charset)
        
        # no cc or bcc
        mail.cc = mail.bcc = nil
        
        # tag the subject line
        mail.subject = "[DIVERTED] " + mail.subject
        
        logger.info "Diverting mail to: #{divert_to}" unless logger.nil?
      end
      deliver_without_diversion!(mail)
    end
  end
end
