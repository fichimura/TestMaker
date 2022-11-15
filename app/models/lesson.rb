class Lesson < ApplicationRecord
  belongs_to :course
  validates :titulo, :conteudo, :course, presence: true


  extend FriendlyId
  friendly_id :titulo, use: :slugged
end
