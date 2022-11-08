class Course < ApplicationRecord
    validates :titulo,  presence: true
    validates :descricao, presence: true, length: { :minimum => 5 }
    
    belongs_to :user
    def to_s
        titulo
    end
   

end
