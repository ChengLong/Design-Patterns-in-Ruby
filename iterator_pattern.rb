class Account
  attr_accessor :name, :balance
  
  def initialize(name, balance)
    @name = name
    @balance = balance
  end
  
  # for Enumerable#max, #min, or #sort
  def <=>(other)
    balance <=> other.balance
  end
end

class Portfolio
  include Enumerable
  
  def initialize
    @accounts = []
  end
  
  def each(&block)
    @accounts.each(&block)
  end
  
  def add_account(account)
    @accounts << account
  end 
end
