# == Schema Information
#
# Table name: notifications
#
#  id      :integer          not null, primary key
#  message :string
#  ntype   :string
#

class Notification < ActiveRecord::Base
  validates :ntype, :message,  presence: true
end
