class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true, length: {minimum: 2}
  
  has_many :photos,        dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  def to_param
    name
  end
end
