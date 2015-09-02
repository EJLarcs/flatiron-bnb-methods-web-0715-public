class Review < ActiveRecord::Base
  #associations
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"


  #validations
  validates :rating, presence: true
  validates :description, presence: true
  #conditional Validations
  validate :ability_to_review


private
  def ability_to_review

    unless reservation && reservation.status == "accepted" && Time.now > reservation.checkout
      errors.add(:review, "Permission to review not granted")
    end

  end

end
