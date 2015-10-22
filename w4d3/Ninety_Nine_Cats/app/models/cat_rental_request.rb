class CatRentalRequest < ActiveRecord::Base
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  # validate :overlapping_requests
  
  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id
  )

  belongs_to(
    :requester,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  def approve!
    self.status = "APPROVED" unless overlapping_requests
    self.save!
    overlapping_pending_requests.each do |pending_request|
      pending_request.denied!
    end
  end

  def denied!
    self.status = "DENIED"
  end

  private

  def overlapping_requests
    if !overlapping_approved_requests.empty?
      errors[:status] << "denied! Overlapping rental date request"
      return true
    end
  end

  def overlapping_approved_requests
    CatRentalRequest.where("cat_id = ?", self.cat_id)
                    .where("status = 'APPROVED' ")
                    .where("NOT (start_date > ? OR
                    end_date < ?)", self.end_date, self.start_date)
  end

  def overlapping_pending_requests
    CatRentalRequest.where("cat_id = ?", self.cat_id)
                    .where("status = 'PENDING' ")
                    .where("NOT (start_date > ? OR
                    end_date < ?)", self.end_date, self.start_date)
  end

end
