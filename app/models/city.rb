require 'pry'
class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def self.highest_ratio_res_to_listings

     reservations = []
     listings = []
       City.first.listings.each do |listing|
         listings << listing
         listing.reservations.each do |reservation|
           reservations << reservation
         end
       end
      first = reservations.length.to_f / listings.length.to_f

       reservations_2 = []
       listings_2 = []
         City.last.listings.each do |listing|
           listings_2 << listing
           listing.reservations.each do |reservation|
             reservations_2 << reservation
           end
         end
         second = reservations_2.length.to_f / listings_2.length.to_f

    if first > second
      City.first
    elsif second > first
      City.last
   end
end

   def self.most_res
     reservations = []
       City.first.listings.each do |listing|
         listing.reservations.each do |reservation|
           reservations << reservation
         end
       end

      reservations_2 = []
       City.last.listings.each do |listing|
         listing.reservations.each do |reservation|
           reservations_2 << reservation
         end
       end

      if reservations.length > reservations_2.length
        City.first
      elsif reservations_2.length > reservations.length
        City.last
      end
   end



  def city_openings(check_out, check_in)
    date_range = [check_out..check_in]
    available_listings = []
    Reservation.all.each do |reservation|
      unless date_range.include?(reservation.checkin)
       available_listings  << reservation.listing
      end
     end
    available_listings
  end



end
