class User < ActiveRecord::Base
  #associations
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'

  # as a host, knows about the guests its had (FAILED - 8)
  #  as a guest, knows about the hosts its had (FAILED - 9)
  #  as a host, knows about its reviews from guests (FAILED - 10)

  def guests
    #as a host, a user has many listings
    guests =[]
    self.listings.each do |listing|
    #every listing has many reservations
      listing.reservations.each do |reservation|
      #every reservation has a guest
       guests << reservation.guest
      end
    end
    guests
  end

  def hosts
    hosts = []
    self.trips.each do |trip|
      hosts << trip.listing.host
    end
    hosts
  end

  def host_reviews
    reviews = []
    self.listings.each do |listing|
    #every listing has many reservations
      listing.reservations.each do |reservation|
      #every reservation has a review (from a guest)
       reviews << reservation.review
      end
    end
    reviews
  end


end
