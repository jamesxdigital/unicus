# == Schema Information
#
# Table name: days
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  display_size :integer
#  date         :string
#  ddatey       :string
#  ddatem       :string
#  ddated       :string
#

require 'rails_helper'

RSpec.describe Day, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
