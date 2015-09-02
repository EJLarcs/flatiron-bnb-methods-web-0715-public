class Listing < ActiveRecord::Base
  #associations
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  #validations
  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood, presence: true

  #callbacks
  before_create :change_status
  #when calling a method remember to put : before calling
  after_destroy :listings_destroyed

  #instance methods
  def average_review_rating
    ratings = []
    # Listing.all.each do |listing|
      self.reservations.each do |reservation|
        if reservation.review
        ratings << reservation.review.rating
        end
      end

    ratings

    ratings.sum.to_f/ratings.length
  end

  private
  def change_status
    self.host.update(:host => true)
  end

  def listings_destroyed
    if self.host.listings.empty?
    self.host.update(:host => false)
    end
  end


end
