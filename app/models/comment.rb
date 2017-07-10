class Comment < ApplicationRecord
  scope :original_only, (-> { where(comment_id: nil) })
  scope :until, (->(from, to) { where('(completed_at IS NULL AND created_at < ?) OR (completed_at > ? AND completed_at < ?)', to, from, to) })

  belongs_to :match
  belongs_to :user
  belongs_to :subject, class_name: 'Standard::Subject'
  belongs_to :original_comment, class_name: 'Comment', foreign_key: 'comment_id', optional: true
  has_many   :reply_comments, class_name: 'Comment', foreign_key: 'comment_id'

  def completed_at=(boolean)
    self[:completed_at] = boolean == 'true' ? Time.zone.now : nil
  end
end
