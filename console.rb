require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({
  'name'  => 'Donald',
  'funds' => 25.00
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'Lindsey',
  'funds' => 30.00
  })
customer2.save()

customer3 = Customer.new({
  'name' => 'Erin',
  'funds' => 15.00
  })
customer3.save()

customer4 = Customer.new({
  'name' => 'Rose',
  'funds' => 10.00
  })
customer4.save()

film1 = Film.new({
  'title' => 'Moana',
  'price' => 5.00
  })
film1.save()

film2 = Film.new({
  'title' => 'Jumanji: Welcome to the Jungle',
  'price' => 7.50
  })
film2.save()

film3 = Film.new({
  'title' => 'Trolls: World Tour',
  'price' => 6.80
  })
film3.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })
ticket1.save()

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  })
ticket2.save()

ticket3 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film1.id
  })
ticket3.save()

ticket4 = Ticket.new({
  'customer_id' => customer4.id,
  'film_id' => film1.id
  })
ticket4.save()

ticket5 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })
ticket5.save()

ticket6 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })
ticket6.save()

ticket7 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film3.id
  })
ticket7.save()

ticket8 = Ticket.new({
  'customer_id' => customer4.id,
  'film_id' => film3.id
  })
ticket8.save()


binding.pry
nil
