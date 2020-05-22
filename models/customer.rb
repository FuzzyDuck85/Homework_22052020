require_relative("../db/sql_runner")

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  # def Customer.create(name, funds)
  #    return Customer.new({"name" => name, "funds" => funds})
  # end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE customer_id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    films = pg_result.map {|film_hash| Film.new(film_hash)}
    return films
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map {|customer|Customer.new(customer)}
    return result
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
      values = [@name, @funds, @id]
      SqlRunner.run(sql, values)
  end

  def self.delete_all()
      sql = "DELETE FROM customers"
      SqlRunner.run(sql)
  end

  def Customer.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values)
    return Customer.new(pg_result[0])
  end

  def buy_ticket(title)
    film = self.films(title)
    film_price = film.map{|film|film.price}
    amount = @funds -= film_price
    return @funds
  end

end
