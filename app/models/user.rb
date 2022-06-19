class User < ApplicationRecord
  has_secure_password
  validates :email, { uniqueness: true, presence: true }

  
  validates :name, { presence: true }
  def posts
    Post.where(user_id: id)
  end
end
