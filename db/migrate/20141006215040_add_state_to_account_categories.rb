class AddStateToAccountCategories < ActiveRecord::Migration
  class Account
    class Category < ActiveRecord::Base
      self.table_name = 'account_categories'
      enum state: [:income,
                   :expense,
                   :current_asset,
                   :current_liability
                  ]
      enum effect: [:no_effect,
                    :add,
                    :subtract
                   ]
    end
  end

  def up
    add_column :account_categories, :state, :integer
    add_column :account_categories, :effect, :integer
    add_column :account_categories, :salary, :boolean, default: false
    add_column :account_categories, :cumulative, :boolean, default: false
    Account::Category.find_each do |category|
      case category.definition.downcase
      when 'in'
        category.income!
        category.add!
      when 'ex'
        category.expense!
        category.subtract!
      when 'ca'
        category.current_asset!
        category.no_effect!
        category.subtract! if category.code == '1225'
        category.update cumulative: true
      when 'cl'
        category.current_liability!
        category.add!
      end
      category.update salary: true if category.name.downcase.include? 'salary'
    end
    remove_column :account_categories, :definition, :string
  end

  def down
    add_column :account_categories, :definition, :string
    Account::Category.find_each do |category|
      category.defintion = 'IN' if category.income?
      category.defintion = 'EX' if category.expense?
      category.defintion = 'CA' if category.current_asset?
      category.defintion = 'CL' if category.current_liability?
    end
    remove_column :account_categories, :state, :integer
    remove_column :account_categories, :effect, :integer
    remove_column :account_categories, :salary, :boolean, default: false
    remove_column :account_categories, :cumulative, :boolean, default: false
  end
end
