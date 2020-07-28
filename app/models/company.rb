class Company < ApplicationRecord
  has_rich_text :description

  validates :name, :zip_code, presence: :true
  validate :validate_zip_code
  validates :email, allow_blank: true, email: true

  before_save :update_city_state, if: :zip_code_changed?

  private

  def update_city_state
    zipcode_decoded = ZipCodes.identify(zip_code) || {}
    self.city = zipcode_decoded[:city]
    self.state = zipcode_decoded[:state_code]
  end

  def validate_zip_code
    return if ZipCodes.identify(zip_code)
    errors.add(:zip_code, :invalid, message: I18n.t('error.zip_code'))
  end
end
