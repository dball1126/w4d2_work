# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper 

    COLOR = {
        :black => 'black',
        :brown => 'brown',
        :white => 'white',
        :orange => 'orange',
        :mixed => 'mixed',
        :yellow => 'yellow',
    }
    validates :birth_date, :name, :sex, :description, :color, presence: true
    validates :color, inclusion: { in: COLOR.values, 
      message: "%{value} is not a valid color" }
    
    validates :sex, inclusion: { in: %w(M F f m), 
     message: 'you must choose M or F for male and female' }

    has_many :cat_rental_requests, 
        dependent: :destroy, 
        primary_key: :id,
        foreign_key: :cat_id,
        class_name: :CatRentalRequest

    def age
        @age = ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
    end 

end
