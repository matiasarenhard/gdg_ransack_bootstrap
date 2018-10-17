# RoR - Ransack - Bootstrap

Simple project created in https://www.meetup.com/pt-BR/GDG-Toledo-PR/events/253753852/ .

Steps from reproduces this project.

Ingredients:

	Ruby : 2.5.1
    Rails : 5.2.1

https://gorails.com/setup/ubuntu/16.04 (Click in your S.O)


 1 - Run this commands from create project

   ```
rails new gdg_ransack_bootstrap
cd gdg_ransack_bootstrap
bundle install
```
 2 - After create project and enter inside they, now we need create scaffolds.
 ```
rails g scaffold brand name:string
rails g scaffold supplier name:string email:string
rails g scaffold product name:string description:string price:integer supplier:references brand:references
```

3 - Ok, after create CRUDS, is necessary finish relationships of `brands - products` and `supplier - product`.
   insert this line in `supplier.rb` and `brand.rb` files
   ```
has_many :products
```

4 - Create Database
```
rake db:create
rake db:migrate
```

5 - Run project
```
rails s
```

6 - go to localhost:3000 in your browser.

7 - in file `routes.rb` and insert this line
```
root :to => "products#index"
```
8 - in file `_form.html.erb` inside of `app/views/products/_form.html.erb`
  change `<%= form.text_field :supplier_id %>` to
  ```
	<%= form.collection_select :supplier_id, Supplier.all, :id, :name %>
```
 and  `<%= form.text_field :brand_id %> ` to

 ```
	<%= form.collection_select :brand_id, Brand.all, :id, :name %>
```
