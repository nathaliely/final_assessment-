class Item < ApplicationRecord
  belongs_to :user
  has_many :images
  def completed?
    !completed_at.blank?
  end

 scope :title, -> (title) { where title: title }


end
