rizzo = User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111")
kris = User.create!(first_name: "Kris", last_name: "Bryant", email: "krisb6579@gmail.com", password: "password", phone: "2222222222")
addison = User.create!(first_name: "Addison", last_name: "Russell", email: "arussell@gmail.com", password: "password", phone: "3333333333")
david = User.create!(first_name: "David", last_name: "Ross", email: "drossgrandpa@gmail.com", password: "password", phone: "4444444444")
dexter = User.create!(first_name: "Dexter", last_name: "Fowler", email: "yaboidex@gmail.com", password: "password", phone: "5555555555")

cubs = Group.create!(name: "Cubs")

m1 = Membership.create!(member_id: rizzo.id, group_id: cubs.id)
m2 = Membership.create!(member_id: kris.id, group_id: cubs.id)
m3 = Membership.create!(member_id: addison.id, group_id: cubs.id)
m4 = Membership.create!(member_id: david.id, group_id: cubs.id)
m5 = Membership.create!(member_id: dexter.id, group_id: cubs.id)


event = Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 6), settled?: false, group: cubs)

x1 = Expense.create!(event_id: event.id, spender_id: rizzo.id, description: "gas", amount: 27.34, location: "Chicago")
x2 = Expense.create!(event_id: event.id, spender_id: rizzo.id, description: "dinner", amount: 58.21, location: "Des Moines")
x3 = Expense.create!(event_id: event.id, spender_id: rizzo.id, description: "hotel", amount: 117.86, location: "Omaha")
x4 = Expense.create!(event_id: event.id, spender_id: kris.id, description: "gas", amount: 96.53, location: "Des Moines")
x5 = Expense.create!(event_id: event.id, spender_id: kris.id, description: "food", amount: 60.34, location: "Davenport")
x6 = Expense.create!(event_id: event.id, spender_id: addison.id, description: "snacks", amount: 5.21, location: "DeKalb")
x7 = Expense.create!(event_id: event.id, spender_id: addison.id, description: "gatorade", amount: 3.28, location: "DeKalb")
x8 = Expense.create!(event_id: event.id, spender_id: david.id, description: "tums", amount: 3.65, location: "DeKalb")


