require 'securerandom'
module TokenGeneratorHelper
  def self.sec_random_token_generator
    token = SecureRandom.uuid.gsub(/\-/,'')
    return token
  end
end
