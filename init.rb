TMail::HeaderField.send :include, TMail::DivertedHeaders
TMail::Mail.send :include, TMail::DivertedAccessors
ActionMailer::Base.send :include, ActionMailer::Diversion
