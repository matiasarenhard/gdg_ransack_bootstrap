# RoR - Ransack - Bootstrap

Simple project created at https://www.meetup.com/pt-BR/GDG-Toledo-PR/events/253753852/ .

Steps to reproduce this project.

Ingredients:

	Ruby : 2.5.1
    Rails : 5.2.1

https://gorails.com/setup/ubuntu/16.04 (Click in your S.O)


 1 - Run this commands to create the project

   ```
rails new gdg_ransack_bootstrap
cd gdg_ransack_bootstrap
bundle install
```
 2 - After create the project and get into the folder, you must now create scaffolds.
 ```
rails g scaffold brand name:string
rails g scaffold supplier name:string email:string
rails g scaffold product name:string description:string price:integer supplier:references brand:references
```

3 - Ok, after CRUDS be created, declare relationships of `brands - products` and `supplier - product`.
   insert this line into `supplier.rb` and `brand.rb` files
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

7 - `routes.rb` and insert this line
```
root :to => "products#index"
```
8 -  `_form.html.erb` inside of `app/views/products/_form.html.erb`
  change `<%= form.text_field :supplier_id %>` to
  ```
	<%= form.collection_select :supplier_id, Supplier.all, :id, :name %>
```
 and  `<%= form.text_field :brand_id %> ` to

 ```
	<%= form.collection_select :brand_id, Brand.all, :id, :name %>
```

9 -  `Gemfile` insert these lines
```
	gem 'bootstrap', '~> 4.0.0'
	gem 'jquery-rails'
	gem "font-awesome-rails"
	gem 'ransack'
```
 run `bundle install`

10 - `application.css` change extension to `application.sccs` and change all lines to
```
@import "bootstrap";
```

11 - `application.js` change all lines to
```
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery_ujs
//= require_tree .
```

12 - in path `config/initializers` create new file `ransack.rb` and insert this
```
Ransack.configure do |config|
  config.search_key = :query
  config.ignore_unknown_conditions = false
  config.hide_sort_order_indicators = true
end

```
13 - `Product.rb` insert  
```
	whitelisted_ransackable_associations = %w[supplier brand]
```

14 -  `app/views/layouts/application.html.erb` change lines inside of tag `<body></body>`
```
<body>
	 <ul class="nav justify-content-center">
			 <li class="nav-item">
				<!-- <%= image_tag 'gdg.jpeg', width: '100' %> -->
			 </li>
	 </ul>
	 <div class="container">
		 <%= yield %>
	 </div>
 </body>

```


15 -  `products_controller.rb` change index method
```
  def index
     @search = Product.all.ransack(params[:query])
     @products = @search.result
  end
```
16 - `app/views/products/index.html.erb` change all lines
 ```
	<p id="notice"><%= notice %></p>

	<h1>Products</h1>

	<table class="table">
	  <%= search_form_for @search, url: products_path do |f| %>
	      <div class="row">
	       <div class="col">
		  <label>Name</label>
		  <%= f.search_field :name_cont, placeholder: 'Name', class: 'form-control' %>
	       </div>
		  <div class="col">
		    <label>Price</label>
		    <%= f.search_field :price_eq, placeholder: 'Price', class: 'form-control' %>
		 </div>
		<div class="col">
		   <label>Brand</label>
		   <%= f.search_field :brand_name_cont, placeholder: 'Brand', class: 'form-control' %>
		</div>
		<div class="col">
		   <label>Supplier Name/Email</label>
		   <%= f.search_field :supplier_email_or_supplier_name_cont, placeholder: 'Supplier', class: 'form-control' %>
		</div>
		<div class="col">
		  <br>
		   <%= f.submit 'Buscar', class: 'btn btn-info' %>
		</div>
	     </div>
	    <br><br>
	    <thead>
		<tr>
		   <th><%= sort_link(@search, :name) %></th>
		   <th>Description</th>
		   <th><%= sort_link(@search, :price) %></th>
		   <th>Supplier</th>
		   <th>Email Supplier</th>
		   <th>Brand</th>
		   <th colspan="3"></th>
		</tr>
	     </thead>
	  <% end %>

	  <tbody>
	    <% @products.each do |product| %>
	      <tr>
		<td><%= product.name %></td>
		<td><%= product.description %></td>
		<td><%= product.price %></td>
		<td><%= product.supplier.name %></td>
		<td><%= product.supplier.email %></td>
		<td><%= product.brand.name %></td>
		<td><%= link_to 'Show', product %></td>
		<td><%= link_to 'Edit', edit_product_path(product) %></td>
		<td><%= link_to 'Destroy', product, method: :delete, data: { confirm: 'Are you sure?' } %></td>
	      </tr>
	    <% end %>
	  </tbody>
	</table>

	<br>

	<%= link_to 'New Product', new_product_path, class: 'btn btn-success' %>

 ```
17 - run `rails s`

18 -  go to `http://localhost:3000/brands/new` in your browser, and create a `brand`.

19 -  go to `http://localhost:3000/suppliers/new` in your browser, and create a `supplier`.

20 -  go to `http://localhost:3000/products/new` in your browser, and create a `product`.

21 - `http://localhost:3000` and finish it!
