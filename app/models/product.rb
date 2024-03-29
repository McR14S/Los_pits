class Product < ApplicationRecord
    include PgSearch::Model
    include Favoritable

    pg_search_scope :search_full_text, against: {
        title: 'A',
        description: 'B'
    }

    ORDER_BY = {
        newest: "created_at DESC",
        expensive: "price DESC",
        cheapest: "price ASC"
    }


    #datos de la imagenes
    has_one_attached :photo

    #datos del modelo
    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true
    validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }



    #modelo product pertenece a una categoria
    belongs_to :category
    #le asigna el ID del usuario logeado
    belongs_to :user, default: -> { Current.user }

    #Refactorizar consulta de ID del usuario logeado
    def owner?
        user_id == Current.user&.id
    end

   def broadcast 
    broadcast_replace_to self, partial: 'products/product_details', locals: { product: self}
   end

end
