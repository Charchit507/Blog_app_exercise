class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  # has_many :articles, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
