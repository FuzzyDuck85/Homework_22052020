require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets ON customers.id = tickets.customer_id
    WHERE tickets.film_id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    customers = pg_result.map {|customer_hash| Customer.new(customer_hash)}
    return customers
  end

  def self.all()
    sql = "SELECT * FROM films"
    film = SqlRunner.run(sql)
    result = Film.map_items(film)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films SET
    (
      title,
      price
      ) =
      (
        $1, $2
      )
      WHERE id = $3"
      values = [@title, @price, @id]
      SqlRunner.run(sql, values)
  end

  # def remaining_funds()
  #   tickets = self.tickets()
  #   casting_fees = casting.map{|casting| casting.fee}
  #   combined_fees = casting_fees.sum
  #   return @budget - combined_fees
  # end

  def self.map_items(film_data)
      result = film_data.map{|film_hash| Film.new(film_hash)}
      return result
  end
end