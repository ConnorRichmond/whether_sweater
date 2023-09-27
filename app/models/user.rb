class User < ApplicationRecord 
  validates_presence_of :email, :api_key
  validates :email, uniqueness: { case_sensitive: false }
  has_secure_password

  def generate_key 
    string = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
    # is 62 max? would not "get" more in test
    update(api_key: string.shuffle.take(62).join(""))
  end

end