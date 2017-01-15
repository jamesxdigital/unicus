# == Schema Information
#
# Table name: training_categories
#
#  id         :integer          not null, primary key
#  category   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TrainingCategory < ActiveRecord::Base
end
