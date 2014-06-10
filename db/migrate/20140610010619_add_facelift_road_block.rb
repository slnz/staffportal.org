class AddFaceliftRoadBlock < ActiveRecord::Migration
  def change
    Roadblock.create(title: 'Facelift', message: "We've overhauled the design of MSP making it easier for you to find things you need.")
  end
end
