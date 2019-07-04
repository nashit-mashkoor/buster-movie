class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  has_one_attached :profile_pic

  attr_accessor :remove_profile_pic

  after_save :purge_profile_pic, if: :remove_profile_pic
  def purge_profile_pic
    profile_pic.purge_later
  end
end
