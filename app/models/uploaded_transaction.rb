class UploadedTransaction < ApplicationRecord
  belongs_to :listing_agent, required: false, class_name: "Agent"
  belongs_to :selling_agent, required: false, class_name: "Agent"

  scope :single_family_homes, -> { where(property_type: "single_family_home") }
  scope :sold, -> { where(status: "sold") }
  validates :address, uniqueness: { scope: [:selling_date, :zip] }


  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end

  require 'csv'

  def self.import(file)

    CSV.foreach(file.path, headers: true) do |row|
      UploadedTransaction.create! row.to_hash
    end
  end
end
