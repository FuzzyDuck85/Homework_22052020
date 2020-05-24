require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor : :film_id, showing_time

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @showing_time = options['showing_time'].to_i
  end

  def save()
    sql = "INSERT INTO screenings
    (film_id, showing_time) VALUES ($1, $2) RETURNING id"
    values = [@film_id, showing_time]
    screening = SqlRunner.run( sql,values ).first
    @id = screening['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    screening = SqlRunner.run(sql)
    result = screenings.map { |screening| Screening.new( screening ) }
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

  def ticket()
    sql = "SELECT * FROM tickets WHERE id = $1"
    pg_result = SqlRunner.run(sql, values)
    ticket_hash = pg_result.first
    ticket = Customer.new(ticket_hash)
    return ticket
  end

  def update()
    sql = "UPDATE screenings SET (film_id, showing_time) = ($1, $2) WHERE id = $3"
      values = [@film_id, @showing_time, @id]
      SqlRunner.run(sql, values)
  end

  def Screening.find_by_id(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Screening.new(pg_result[0])
  end

end
