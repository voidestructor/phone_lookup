require "./lib/phone_utility"
require "./models/phone_number_wrapper"

class PhoneNumberExtractor
  def self.matches(text)
    PhoneUtility.find_numbers(text, nil).map do |match|
      PhoneNumberWrapper.new(match.number)
    end
  end

  def self.parse(number, region = nil)
    begin
      match = PhoneUtility.parse(number, region)
      match ? PhoneNumberWrapper.new(match) : nil
    rescue Java::ComGoogleI18nPhonenumbers::NumberParseException
      nil
    end
  end
end
