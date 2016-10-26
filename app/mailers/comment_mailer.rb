# coding: utf-8
class CommentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mailer.request_approval.subject
  #
  def request_approval(comment)
    @blog = comment.entry.blog
    @entry = comment.entry
    @comment = comment
    mail to: "admin@example.org", from: 'noreply@example.com', subject: '新しいコメントが投稿されました'
  end
end
