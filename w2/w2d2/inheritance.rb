class Employee
  attr_accessor :name, :title, :salary, :boss
  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end


end

class Manager < Employee
  attr_accessor :employees
  def initialize(name, title, salary, boss = nil)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    return 0 if @employees.empty?

    current_employees_sum = @employees.inject(0) do |accum, employee|
      accum + employee.salary
    end

    bonus_for_employees = current_employees_sum * multiplier
    @employees.each do |employee|
      next unless employee.is_a? Manager
      bonus_for_employees += employee.bonus(multiplier)
    end
    bonus_for_employees
  end

  def assign(employee)
    employee.boss = self
    self.employees << employee
  end
end