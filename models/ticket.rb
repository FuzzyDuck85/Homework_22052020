require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  # def Ticket.create(customer, film)
  #   if customer.buy_ticket(film.price())
  #     return Ticket.new({"customer_id" => customer.id(), "film_id" => film.id()})
  #   end
  # end

  def save()
    sql = "INSERT INTO tickets
    (customer_id, film_id) VALUES ($1, $2) RETURNING id"
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
    pg_result = SqlRunner.run(sql, values)
    film_hash = pg_result[0]
    film = Film.new(film_hash)
    return film
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    pg_result = SqlRunner.run(sql, values)
    customer_hash = pg_result.first
    customer = Film.new(customer_hash)
    return customer
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
      values = [@customer_id, @film_id, @id]
      SqlRunner.run(sql, values)
  end

  def Ticket.find_by_id(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Ticket.new(pg_result[0])
  end

end
