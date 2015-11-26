class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  validates :link, :content, presence: true
  
end
