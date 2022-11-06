class Course < ApplicationRecord
    validates :titulo,  presence: true
    validates :descricao, presence: true, length: { :minimum => 5 }
end
