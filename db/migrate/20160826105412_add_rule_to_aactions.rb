class AddRuleToAactions < ActiveRecord::Migration
  def change
    add_reference :aactions, :rule, index: true, foreign_key: true
  end
end
