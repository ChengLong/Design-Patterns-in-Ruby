class BankAccount
  attr_reader :balance
  
  def initialize(starting_balance=0)
    @balance = starting_balance
  end
  
  def deposit(amount)
    @balance += amount
  end
  
  def withdraw(amount)
    @balance -= amount
  end 
end

require 'etc'

# separation of concerns, protection proxy ONLY worries about security and it knows nothing about banking stuff. 
# easy to change security scheme 
# but think about the methods inherited from Object, like to_s
class AccountProtectionProxy
  def initialize(real_account, owner_name)
    @subject = real_account
    @owner_name = owner_name
  end
  
  # use method_missing to avoid repeating all interfaces of the subject. 
  def method_missing(name, *args)
    check_access
    @subject.send( name, *args )
  end
  
  def check_access
    if Etc.getlogin != @owner_name
      raise "Illegal access: #{Etc.getlogin} cannot access account."
    end
  end 
end

# delay creation of the subject until necessary
class VirtualProxy
  def initialize(&creation_block)
    @creation_block = creation_block
  end
  
  def method_missing(name, *args)
    s = subject
    s.send( name, *args)
  end

  def subject
    @subject = @creation_block.call unless @subject
    @subject
  end
end

# Remote Proxy Pattern
class MathService
  def add(a, b)
    return a + b
  end
end

# on machine M1
require 'drb/drb'
math_service=MathService.new # real math service
DRb.start_service("druby://localhost:3030", math_service)
DRb.thread.join

# on machine M2
require 'drb/drb'
DRb.start_service
math_service = DRbObject.new_with_uri("druby://localhost:3030") # remote proxy
sum = math_service.add(2,2)
