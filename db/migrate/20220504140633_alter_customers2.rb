class AlterCustomers2 < ActiveRecord::Migration[6.0]
  def change
    add_index :customers,
              %i[gender family_name_kana given_name_kana],
              name: 'index_customers_on_gender_and_furigana'
  end
end
