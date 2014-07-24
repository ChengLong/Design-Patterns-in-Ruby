require 'observer'

class Employee
  # http://ruby-doc.org/stdlib-2.0.0/libdoc/observer/rdoc/Observable.html
  include Observable
  
  attr_reader :name, :address
  attr_reader :salary

  def initialize(name, title, salary)
   @name = name
   @title = title
   @salary = salary
  end

  def salary=(new_salary) 
    old_salary = @salary
    @salary = new_salary 
    if old_salary != new_salary
      changed # notify_observers method will not actually make any notifications if the changed flag is not set to true
      notify_observers(self) # Each call to notify_observers sets the changed flag back to false
    end
  end
end

class Payroll
  # observers must implement a method called update to receive notifications
  def update(changed_employee)
    puts("Cut a new check for #{changed_employee.name}!")
    puts("His salary is now #{changed_employee.salary}!")
  end
end
