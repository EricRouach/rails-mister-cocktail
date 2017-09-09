class Cocktail < ApplicationRecord
  before_save :default_values
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  validates :name, presence: true, uniqueness: true
  mount_uploader :photo, PhotoUploader


  def nbr_ingredient
    id = self.id
    @doses = Dose.where(cocktail_id: id)
    sum = 0
    @doses.each { |_dose| sum += 1 }
    sum
  end

  def add_vote
    self.vote += 1
    self.save
  end

  private

  def default_values
    self.vote = 0 if self.vote.nil?
  end
end
