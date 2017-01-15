# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  content_id   :integer
#  sender_id    :integer
#  seen         :boolean
#  message_type :string
#  title        :string
#  message      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_messages_on_content_id  (content_id)
#  index_messages_on_sender_id   (sender_id)
#  index_messages_on_user_id     (user_id)
#

class Message < ActiveRecord::Base
	belongs_to :recipient, foreign_key:'user_id', class_name:'User'

	scope :sorted, lambda{order("messages.created_at DESC")}
end
