# == Schema Information
#
# Table name: company_values
#
#  id            :integer          not null, primary key
#  company_value :string
#  icon          :string
#  colour        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CompanyValue < ActiveRecord::Base
  validates :company_value, :presence => true
  validates :icon, :presence => true
  validates :colour, :presence => true
end
