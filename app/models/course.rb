class Course < ApplicationRecord
    validates :titulo, :linguagens , :nivel,  presence: true
    validates :descricao, presence: true, length: { :minimum => 5 }
    
    belongs_to :user
    has_many :lessons, dependent: :destroy
    has_many :enrollments
    has_many :user_lessons, through: :lessons

    validates :title, uniqueness: true

    scope :latest, -> { limit(3).order(created_at: :desc) }
    scope :top_rated, -> { limit(3).order(average_rating: :desc, created_at: :desc) }
    scope :popular, -> { limit(3).order(enrollments_count: :desc, created_at: :desc) }

    def to_s
        titulo
    end

    def update_rating
      if enrollments.any? && enrollments.where.not(avaliacao: nil).any?
        update_column :average_rating, (enrollments.average(:avaliacao).round(2).to_f)
      else
        update_column :average_rating, (0)
      end
    end
   
    extend FriendlyId
    friendly_id :titulo, use: :slugged

    NIVEIS = [:"Iniciante", :"Intermediario", :"Avançado"]
    def self.niveis
      NIVEIS.map { |nivel| [nivel, nivel] }
    end

    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user } 

    def inscritos(user)
      self.enrollments.where(user_id: [user.id], course_id: [self.id]).empty?
    end
end
