# == Schema Information
#
# Table name: peer_reviews
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  manager_id             :integer
#  e_objective_response   :text
#  e_overall_comments     :text
#  e_personal_development :text
#  m_objective_response   :text
#  m_overall_comments     :text
#  m_personal_development :text
#  deadline               :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  photo                  :string
#

class PeerReview < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
end
