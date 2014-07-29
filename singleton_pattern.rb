require 'singleton'

class Klass
  include Singleton

  def initialize 
    # ...
  end
end

# get an instance
a = Klass.instance
b = Klass.instance

a == b # true
Klass.new # NoMethodError - new is private

#This above is achieved by:
#Making Klass.new and Klass.allocate private.
#Overriding Klass.inherited(sub_klass) and Klass.clone() to ensure that the Singleton properties are kept when inherited and cloned.
#Providing the Klass.instance() method that returns the same object each time it is called.
#Overriding Klass._load(str) to call Klass.instance().
#Overriding Klass#clone and Klass#dup to raise TypeErrors to prevent cloning or duping.
