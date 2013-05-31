require 'bigdecimal'
require 'bigdecimal/util'

def yank(amount)
  amt, currency = amount.split(" ") #this is pretty easy, seeing as though there is one space between the currency and the amount.
   # convert the number to a float from a string
  #return them both
  return amt, currency
end

a, b = yank("70.00 USD")
printf("Test is %.2f", a.to_f) #Hurrah, it works, but it doesnt keep the trailing 0's, so we'll have to fix that somehow.