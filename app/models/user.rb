class User < ApplicationRecord

  has_one :rol

  has_secure_password

  before_save :email_to_lowercase

  validates :first_name, presence: true
  validates :last_name,  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  VALID_PASSWORD_REGEX = /\A
                          (?=.{8,})          # Must contain 8 or more characters
                          (?=.*\d)           # Must contain a digit
                          (?=.*[a-z])        # Must contain a lower case character
                          (?=.*[A-Z])        # Must contain an upper case character
                          (?=.*[[:^alnum:]]) # Must contain a symbol
                        /x
  validates :password, presence: true, length: { minimum: 8 }, format: { with: VALID_PASSWORD_REGEX }

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  # Returns true if the given token matches the digest.
  def autenticado?(atributo, token)
    digest = send("#{atributo}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  
  def has_rol?(*rols)
    rols.include?(rol.name)
  end

  def full_name
    first_name + ' ' + last_name
  end

  def self.find(text)    
    if text.present?
      conditions, arguments = [], []
      terms = text.split
      terms.each do |key|
        if key.include?("id:")
          conditions << "id = ?"
          arguments << "#{key.delete("id:")}"
        else
          conditions << "first_name ILIKE ? or last_name ILIKE ? or email ILIKE ?"
          3.times { arguments << "%#{key}%" }
        end
      end
      where([conditions.join(' or '), arguments].flatten)
    else      
      where(nil)
    end
  end

  private

    def email_to_lowercase
      self.email = email.downcase
    end

end