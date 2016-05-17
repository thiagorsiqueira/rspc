class Project < ActiveRecord::Base
	include PublicActivity::Model

	mount_uploader :avatar, AvatarUploader

	belongs_to :user, :foreign_key => :creator_id
	has_and_belongs_to_many :abilities
	has_and_belongs_to_many :interests

	has_many :members
  	has_many :users, :through => :members

  	has_many :topics
  	has_many :publications
  	has_many :tasks


  	validates :name, presence: true
  	validates :place, presence: true
end
