class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user


  validates :user, :course, presence: true
  validates_uniqueness_of :user_id, scope: :course_id  
  validates_uniqueness_of :course_id, scope: :user_id  
  validate :cant_subscribe_to_own_course 

  validates_presence_of :avaliacao, if: :comentarios?
  validates_presence_of :comentarios, if: :avaliacao?

  scope :pending_review, -> { where(avaliacao: [0, nil, ""], comentarios: [0, nil, ""]) }
  scope :reviewed, -> { where.not(avaliacao: [0, nil, ""]) }
  scope :latest_good_reviews, -> { order(avaliacao: :desc, created_at: :desc).limit(3) }

  after_save do
    unless avaliacao.nil? || avaliacao.zero?
      course.update_rating
    end
  end

  after_destroy do
    course.update_rating
  end

  def to_s
    user.to_s + " " + course.to_s
  end

  protected
  def cant_subscribe_to_own_course
    if self.new_record?
      if self.user_id.present?
        if self.user_id == course.user_id
          errors.add(:base, "Vocẽ não pode inscrever-se no seu curso")
        end
      end
    end
  end


end
