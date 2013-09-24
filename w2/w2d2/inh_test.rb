require './inheritance'

ceo = Manager.new("bossman", "CEO", 1000)

vp = Manager.new("bob", "VP", 400)
ceo.assign(vp)

cto = (Manager.new("jim", "CTO", 800))
ceo.assign(cto)

ceo.assign(Employee.new("sexyface", "escort", 900))


vp.assign(Employee.new("kevin", "worker", 100))
vp.assign(Employee.new("sarah", "intern", 10))

cto.assign(Employee.new("margaret", "accountant", 200))
cto.assign(Employee.new("primrose", "florist", 8))

puts "ceo at 1x bonus #{ceo.bonus(1)}"

puts "ceo at 2x bonus #{ceo.bonus(2)}"




