class Course < ApplicationRecord
    validates :titulo, :linguagens , :nivel,  presence: true
    validates :descricao, presence: true, length: { :minimum => 5 }
    
    belongs_to :user
    def to_s
        titulo
    end
   
    extend FriendlyId
    friendly_id :titulo, use: :slugged

    NIVEIS = [:"Iniciante", :"Intermediario", :"Avançado"]
    def self.niveis
      NIVEIS.map { |nivel| [nivel, nivel] }
    end

end