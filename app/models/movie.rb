# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Movie < ApplicationRecord
  validates :title, presence: true
  
end
