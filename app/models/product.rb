class Product < ApplicationRecord
  belongs_to :supplier
  belongs_to :brand
  whitelisted_ransackable_associations = %w[supplier brand]
end
