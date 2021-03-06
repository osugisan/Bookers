class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  attachment :profile_image

  def following?(other_user)
    followings.include?(other_user)
  end

  def User.search(search, user_or_book, how_search)
    if search.empty?
      User.all
    elsif user_or_book == "1"
      if how_search == "1"
        User.where(['name LIKE ?', "#{search}"])
      elsif how_search == "2"
        User.where(['name LIKE ?', "#{search}%"])
      elsif how_search == "3"
        User.where(['name LIKE ?', "%#{search}"])
      elsif how_search == "4"
        User.where(['name LIKE ?', "%#{search}%"])
      end
    end
  end

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

end
