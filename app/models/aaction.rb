class Aaction < ActiveRecord::Base
  belongs_to :actor
  belongs_to :rule
end
