require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")
require_relative("../models/transaction")
require_relative("../models/tag")
require_relative("../models/merchant")
also_reload("../models/*")


# INDEX
get "/transactions" do
  @transactions = Transaction.all
  @total = Transaction.total
  erb(:"transactions/index")
end

# INDEX - SORT
get "/transactions/sort_time" do
  @transactions = Transaction.sort_time
  @total = Transaction.total
  erb(:"transactions/index")
end

# INDEX - FILTER
get "/transactions/filter" do
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:"transactions/filter")
end

# INDEX - FILTER
get "/transactions/filtered" do
  print "\n"
  print "PARAMS"
  print params
  print "\n"
  @transactions = Transaction.filter(params)
  print "\n"
  print "TRANSACTIONS"
  print @transactions
  print "\n"
  # @total = Transaction.total
  # need to total just filtered - just do sum_by??
  erb(:"transactions/index")
end

# NEW
get '/transactions/new' do
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:"transactions/new")
end

# SHOW
get '/transactions/:id' do
  @transaction = Transaction.find(params[:id])
  erb(:"transactions/show")
end

# CREATE
post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save
  redirect to '/transactions'
end

# EDIT
get '/transactions/:id/edit' do
  @tags = Tag.all
  @merchants = Merchant.all
  @transaction = Transaction.find(params[:id])
  erb(:"transactions/edit")
end

# UPDATE
post '/transactions/:id' do
  transaction = Transaction.new(params)
  transaction.update
  redirect to "/transactions/#{transaction.id}"
end

# DELETE
post '/transactions/:id/delete' do
  transaction = Transaction.find(params[:id])
  transaction.delete
  redirect to '/transactions'
end
