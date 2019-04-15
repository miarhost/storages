class Profile < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,
    presence: true,
    length: { minimum: 10, maximum: 255 },
    format: {with: VALID_EMAIL_REGEX },
    uniqueness: true
	    
	 validates :first_name, :last_name,
            length: { minimum: 2, maximum: 80 }
end
