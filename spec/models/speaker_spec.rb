# == Schema Information
#
# Table name: speakers
#
#  id                  :integer          not null, primary key
#  speaker_title       :string
#  forename            :string
#  surname             :string
#  organisation        :string
#  biography           :string
#  academic_background :string
#  email               :string
#  website             :string
#  facebook            :string
#  twitter             :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar              :string
#  linkedIn            :string
#  display_email       :string
#  to_display          :string
#

require 'rails_helper'

RSpec.describe Speaker, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
