class Comment < ApplicationRecord
  belongs_to :entry
  validates :body, presence: true

  def approved?
    self.status == 'approved'
  end
end
