# Used stack #

+ [Ruby](http://ruby-lang.org), => `2.6.3`
+ [Rails](http://rubyonrails.org), => `6.0.3`
+ [PostgreSQL](http://www.postgresql.org), => `12.3`

# Usage #

* Environment variables should be filled in `.env.development`: DB_USER, DB_PASSWORD, DB_NAME.
* `rake db:seed` can be used to import recipes from given JSON.
* Use `bundle exec rails s` to start a local server, access it at `localhost:3000`

# Remaining work #

* List ingredients owned by everybody to ignore them in search (add boolean to ingredient)
* Add ingredients_count to recipes, to speed up search query
* Make it more beautiful (literally no CSS used currently), add more info to recipes#show page
