# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  enum public_status: { draft: 0, published: 1, archived: 2, deleted: 3 }

  scope :published, -> { where(public_status: :published) }

  validates :public_status, presence: true, inclusion: { in: public_statuses.keys }

  def delete!
    update!(public_status: :deleted)
  end
end
