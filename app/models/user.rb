class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:github, :google_oauth2]

  has_many :authorizations, dependent: :destroy
  has_many :answers, foreign_key: :author_id, dependent: :destroy
  has_many :questions, foreign_key: :author_id, dependent: :destroy
  has_many :users_badges, dependent: :destroy
  has_many :badges, through: :users_badges

  def author_of?(object)
    id == object.author.id
  end

  def self.find_for_oauth(auth)
    Services::FindForOauth.new(auth).call
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
