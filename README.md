Please follow the step to configured the application.

rake db:create
rake db:migrate 
rake db:seed 


For Testing the Luhn Algorithm

run it in the console 
rails c

Then create the object of page 

page = Page.new

page.check_card_number("1234456677")

page.final_card_number('12353453453')

