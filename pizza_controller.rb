require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require( 'pry-byebug' )
require_relative('models/pizza')


# INDEX route
get('/pizzas') do
  @pizzas =  Pizza.all()
  erb(:index)
end


# NEW
get('/pizzas/new') do
  erb(:new)
end

# if NEW was placed below SHOW it would never work as
# due to cascade SHOW would always take precedence
# the two need to be placed in this order so that
# SHOW is only checked after NEW is checked

# SHOW
get('/pizzas/:id') do
  @pizza = Pizza.find(params[:id])
  erb(:show)
end

# CREATE
post('/pizzas') do
  @pizza = Pizza.new(params)
  @pizza.save
  erb(:create)
  # could instead use:
  # redirect
  # the above will send them to the get version of
  # this path
end


# DELETE
post('/pizzas/:id/delete') do
  Pizza.delete(params[:id])
  redirect('/pizzas')
end


# EDIT
get('/pizzas/:id/edit') do
  @pizza = Pizza.find(params[:id])
  # binding.pry
  erb(:edit)
end

#UPDATE

post('/pizzas/:id') do
  @pizza = Pizza.new(params)
  @pizza.update
  erb(:update)
end
