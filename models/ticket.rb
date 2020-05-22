require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run( sql,values ).first
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    visits = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    # movie = SqlRunner.run(sql, values).first
    # return Film.new(film)
    pg_result = SqlRunner.run(sql, values)
    film_hash = pg_result[0]
    film = Film.new(film_hash)
    return film
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    # values = [@customer_id]
    # customer = SqlRunner.run(sql, values).first
    # return Customer.new(customer)
    pg_result = SqlRunner.run(sql, values)
    customer_hash = pg_result.first
    customer = Film.new(customer_hash)
    return customer
  end

  # def total_fees
  #   sql = "SELECT SUM(fee) FROM castings;"
  #   pg_result = SqlRunner.run(sql, values)
  #   fee_hash = pg_result.first
  #   fee = Movie.new(fee_hash)
  # end
end
