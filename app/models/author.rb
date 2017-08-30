class Author < ApplicationRecord
  authenticates_with_sorcery!
  validates_confirmation_of :password, message: "password should match confirmation", if: :password
end
