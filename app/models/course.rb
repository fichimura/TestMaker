class Course < ApplicationRecord
    validates :titulo,  presence: true
    validates :descricao, presence: true, length: { :minimum => 5 }
    def to_s
        titulo
    end
    has_rich_text :descricao

end
