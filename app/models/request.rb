# == Schema Information
#
# Table name: requests
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string
#  category   :string
#  comments   :text
#  approved   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Request < ActiveRecord::Base

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |request|
				csv << request.attributes.values_at(*column_names)
			end
		end
	end

end
