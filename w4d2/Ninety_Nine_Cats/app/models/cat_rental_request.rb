class CatRentalRequest < ActiveRecord::Base
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  # validate :overlapping_requests

  belongs_to(
  :cat,
  class_name: "Cat",
  foreign_key: :cat_id,
  primary_key: :id
  )

  private

  def overlapping_requests
    if !overlapping_approved_requests.empty?
      errors[:status] << "denied! Overlapping rental date request"
    end
  end

  def overlapping_approved_requests
    CatRentalRequest.where("cat_id = ?", self.cat_id)
                    .where("NOT (start_date > ? OR
                    end_date < ?)", self.end_date, self.start_date)
  end

end
