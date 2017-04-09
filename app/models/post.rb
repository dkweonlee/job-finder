class Post < ApplicationRecord
  before_destroy :destroy_comments
  has_many :comments
  belongs_to :user

  private
   def destroy_comments
     self.comments.delete_all   
   end
end