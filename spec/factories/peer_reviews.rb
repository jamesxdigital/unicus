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

FactoryGirl.define do
  factory :peer_review do
    user_id 1
manager_id 1
e_objective_response "MyText"
e_overall_comments "MyText"
e_personal_development "MyText"
m_objective_response "MyText"
m_overall_comments "MyText"
m_personal_development "MyText"
deadline "2016-04-29 11:24:49"
  end

end
