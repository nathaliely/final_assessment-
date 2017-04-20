class Item < ApplicationRecord
  belongs_to :user

  def completed?
    !completed_at.blank?
  end

 scope :title, -> (title) { where title: title }

 #scoped_search on: [:items]

end
