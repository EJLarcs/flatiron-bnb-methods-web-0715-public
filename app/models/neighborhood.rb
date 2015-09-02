class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  #CLASS METHODS
  def self.highest_ratio_res_to_listings
  # the neighborhood with the highest ratio of reservations to listings
  neighborhood_ratio = 0
  highest_ratio = []
      Neighborhood.all.each do |neighborhood|
        # highest_ratio = nil
        listings = []
        reservations = []
        neighborhood.city.listings.each do |listing|
        listings << listing
          listing.reservations.each do |reservation|
          reservations << reservation
          end
          ratio = reservations.length.to_f / listings.length.to_f
          if ratio > neighborhood_ratio
          neighborhood_ratio = ratio
          highest_ratio << neighborhood
          end
        end
      end
      highest_ratio[0]
    end

 # knows the neighborhood with the most reservations
    def self.most_res
      highest_res = 0
      highest_res_neigh = nil
      Neighborhood.all.each do |neighborhood|
        reservations = []
        neighborhood.city.listings.each do |listing|
          listing.reservations.each do |reservation|
          reservations << reservation
          end
          res_count = reservations.length
          if res_count > highest_res
          highest_res = res_count
          highest_res_neigh = neighborhood
          end
        end
      end
      highest_res_neigh
    end


#INSTANCE METHODS
  def neighborhood_openings(check_out, check_in)
    date_range = [check_out..check_in]
    available_listings = []
    self.city.listings.each do |listing|
       listing.reservations.each do |reservation|
       unless date_range.include?(reservation.checkin)
        available_listings  << reservation.listing
       end
      end
    end
     available_listings
  end



end
