class Condition < ActiveRecord::Base
  belongs_to :sensor
  belongs_to :rule
end
