require_relative( 'models/ticket' )
require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/screening' )
require( 'pry-byebug' )

Ticket.delete_all()
Screening.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({'name'  => 'Donald', 'funds' => 25.00})
customer1.save()
customer2 = Customer.new({'name' => 'Lindsey', 'funds' => 30.00})
customer2.save()
customer3 = Customer.new({'name' => 'Erin', 'funds' => 15.00})
customer3.save()
customer4 = Customer.new({'name' => 'Rose', 'funds' => 10.00})
customer4.save()

film1 = Film.new({'title' => 'Moana', 'price' => 5.00})
film1.save()
film2 = Film.new({'title' => 'Jumanji: Welcome to the Jungle', 'price' => 7.50})
film2.save()
film3 = Film.new({'title' => 'Trolls: World Tour', 'price' => 6.80})
film3.save()
film4 = Film.new({'title' => 'The Lion King', 'price' => 7.20})
film4.save()

screening1 = Screening.new({'film_id' => film1.id, 'start_time' => '2020-04-29 10:00:00', 'empty_seats' => 20})
screening1.save
screening2 = Screening.new({'film_id' => film2.id, 'start_time' => '2020-04-30 16:00:00', 'empty_seats' => 15})
screening2.save
screening3 = Screening.new({'film_id' => film2.id, 'start_time' => '2020-05-01 20:00:00', 'empty_seats' => 1})
screening3.save
screening4 = Screening.new({'film_id' => film3.id, 'start_time' => '2020-05-02 11:00:00', 'empty_seats' => 20})
screening4.save
screening5 = Screening.new({'film_id' => film4.id, 'start_time' => '2020-05-03 14:00:00', 'empty_seats' => 10})
screening5.save
screening6 = Screening.new({'film_id' => film4.id, 'start_time' => '2020-05-03 17:00:00', 'empty_seats' => 10})
screening6.save

customer1.buy_ticket(screening1)
customer2.buy_ticket(screening1)
customer3.buy_ticket(screening1)
customer4.buy_ticket(screening1)

customer1.buy_ticket(screening3)

customer1.buy_ticket(screening2)
customer2.buy_ticket(screening2)

customer1.buy_ticket(screening5)
customer3.buy_ticket(screening5)

customer4.buy_ticket(screening6)

binding.pry
nil
