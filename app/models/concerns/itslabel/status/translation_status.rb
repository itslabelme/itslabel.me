module Itslabel::Status::TranslationStatus
  
  extend ActiveSupport::Concern

  # Constants
  PENDING = "PENDING" 
  APPROVED = "APPROVED"
  REJECTED = "REJECTED" 
  REMOVED = "REMOVED"
  
  STATUS_LIST = {PENDING => "Pending", APPROVED => "Approved", REJECTED => "Rejected", REMOVED => "Removed"}
  REVERSED_STATUS_LIST = {"Pending" => PENDING, "Approved" => APPROVED, "Rejected" => REJECTED, "Removed" => REMOVED}
  STATUS_UI_CLASS = {PENDING => "dark", APPROVED => "success", REJECTED => "warning", REMOVED => "danger"}
  STATUS_UI_ICON = {PENDING => "fa-clock-o", APPROVED => "fa-check", REJECTED => "fa-ban", REMOVED => "fa-trash"}
  STATUS_UI_COLOR = {PENDING => "#FFCC00", APPROVED => "#63b94c", REJECTED => "#4b4b4b", REMOVED => "#ec407a"}

  included do

    validates :status, :presence=> true, :inclusion => {:in => STATUS_LIST.keys, :presence_of => :status, :message => "%{value} is not a valid status" }

    # Approved
    def approved?
      self.status == APPROVED
    end

    def can_approve?
      self.pending? || self.rejected?
    end

    def approve!
      self.can_approve? && self.update_attribute(:status, APPROVED)
    end


    # Reject
    def rejected?
      self.status == REJECTED
    end

    def can_reject?
      self.approved? || self.pending?
    end

    def reject!
      self.can_reject? && self.update_attribute(:status, REJECTED)
    end


    # Pending
    def pending?
      self.status == PENDING
    end

    def can_pending?
      self.approved? || self.rejected?
    end

    def pending!
      self.can_pending? && self.update_attribute(:status, PENDING)
    end

    
    # Remove
    def removed?
      self.status == REMOVED
    end

    def can_remove?
      self.pending? || self.rejected?
    end

    def remove!
      self.can_remove? && self.update_attribute(:status, REMOVED)
    end


    # Check status?
    def status?(st)
      self.status.to_s == st.to_s
    end

    # Update status? 
    # This method is helpful if you are changing status in bulk
    def update_status(status)
      case status
      when PENDING
        self.pending!
      when APPROVED
        self.approve!
      when REJECTED
        self.reject!
      when REMOVED
        self.remove!
      end
    end

    scope :pending, -> { where("#{table_name}": {status: PENDING} ) }
    scope :approved, -> { where("#{table_name}": {status: APPROVED} ) }
    scope :rejected, -> { where("#{table_name}": {status: REJECTED} ) }
    scope :removed, -> { where("#{table_name}": {status: REMOVED} ) }

    scope :status, lambda { |status| where("UPPER(#{table_name}.status)='#{status}'") }
    scope :any_of_the_statuses, lambda { |status| where("UPPER(#{table_name}.status) IN (?)", status) }
    scope :all_statuses_expect, lambda { |status| where("UPPER(#{table_name}.status) NOT IN (?)", status) }
  end

  def display_status
    STATUS_LIST[self.status]
  end

  def status_ui_class
    STATUS_UI_CLASS[self.status]
  end

  def status_ui_icon
    STATUS_UI_ICON[self.status]
  end

  def status_ui_color
    STATUS_UI_COLOR[self.status]
  end

end