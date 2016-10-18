class CommercialEntity
  include Mongoid::Document
  field :name, type: String
  field :auth_token, type: String

  before_create :set_auth_token

  private
  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
