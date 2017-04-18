class AddStateToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :state, index: true, foreign_key: true
  end
end
