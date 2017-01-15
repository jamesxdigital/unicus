# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string           default(""), not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string
#  last_sign_in_ip    :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  manager            :boolean
#  admin              :boolean
#  manager_id         :integer
#  username           :string
#  uid                :string
#  mail               :string
#  ou                 :string
#  dn                 :string
#  sn                 :string
#  givenname          :string
#
# Indexes
#
#  index_users_on_email       (email)
#  index_users_on_manager_id  (manager_id)
#  index_users_on_username    (username)
#

require 'csv'

class User < ActiveRecord::Base
  include EpiCas::DeviseHelper


  has_many :objectives

  has_many :messages

  belongs_to :man,foreign_key: 'manager_id',class_name:'User'
  has_many :minions,class_name:'User',foreign_key:'manager_id'

  #has_many :minions,foreign_key: 'manager_id', class_name:'User'
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end
