class Reservation < ActiveRecord::Base
  #associations
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  #Validations
  validates :checkin, presence: true
  validates :checkout, presence: true
  #Conditional Validations
  validate :no_own_reservations
  validate :checkin_not_before_checkout
  validate :checkin_and_checkout_have_availability

  #instance Methods
  def duration
        duration = self.checkout - self.checkin
  end

  def total_price
    self.duration * self.listing.price
  end

private
# validates that you cannot make a reservation on your own listing (FAILED - 1)
 def no_own_reservations
   if guest == listing.host
     errors.add(:guest, "Please select a listing that is not your own")
   end
 end

 def checkin_and_checkout_have_availability
      if checkin && checkout
        reservation_request = (checkin..checkout)
        listing.reservations.each do |reservation|
          (reservation.checkin..reservation.checkout).each do |date|
            if reservation_request.include?(date)
              errors.add(:checkin, "Sorry! These dates are not available")
            end
          end
        end
        #we need to know the availability of the listing
      end

 end
 # validates that a listing is available at checkin before making reservation (FAILED - 1)
 #   validates that a listing is available at checkout before making reservation (FAILED - 2)
 #   validates that a listing is available at for both checkin and checkout before making reservation (FAILED - 3)

 def checkin_not_before_checkout
   if checkin && checkout
     if checkin >= checkout
       errors.add(:checkout, "Re-evaluate your dates please")
     end
   end
 end

 # validates that a listing is available at checkin before making reservation (FAILED - 2)
 # def checkin_has_availability
 # end
 #
 # validates that a listing is available at checkout before making reservation (FAILED - 3)
 # def checkout_has_availability
 # end
 # validates that a listing is available at for both checkin and checkout before making reservation (FAILED - 4)
 # def checkin_and_checkout_have_availability
 # end
 # validates that checkin is before checkout (FAILED - 5)
 # def checkin_is_before_checkout
 # end
 # validates that checkin and checkout dates are not the same (FAILED - 6)
 # def checkin_and_checkout_different
 # end

end
