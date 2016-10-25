class AddDefaultStatusToCommentStatus < ActiveRecord::Migration[5.0]
  def change
    change_column_default :comments, :status, 'unapproved'
  end
end
