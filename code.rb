require "csv"
require "pg"
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "ingredients")
    yield(connection)
  ensure
    connection.close
  end
end

# CSV.foreach("ingredients.csv", headers: false) do |ingredient|
#   db_connection do |conn|
#     conn.exec_params("INSERT INTO ingredients (ingredient) VALUES ($1)", [ingredient[1]])
#   end
# end

ingredients = db_connection { |conn| conn.exec("SELECT ingredient FROM ingredients") }

ingredients.each_with_index { |ingredient, index| puts "#{index+1}. #{ingredient["ingredient"]}" }
