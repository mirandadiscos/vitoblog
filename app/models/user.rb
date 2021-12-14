class User < ApplicationRecord
  rolify
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
 

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable,:confirmable
end
