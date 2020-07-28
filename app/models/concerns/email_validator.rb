class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[A-Z0-9._+-]+@getmainstreet.com\z/i
      record.errors[attribute] << (options[:message] || I18n.t('error.email_err'))
    end
  end
end
