module Itslabel::Status::TranslationStatus
  
  extend ActiveSupport::Concern

  # Constants
  ACTIVE = "ACTIVE"
  INACTIVE = "INACTIVE" 
  PENDING = "PENDING" 
  REMOVED = "REMOVED"
  
  STATUS_LIST = {ACTIVE => "Active", INACTIVE => "Inactive", PENDING => "Pending", REMOVED => "Removed"}
  REVERSED_STATUS_LIST = {"Active" => ACTIVE, "Inactive" => INACTIVE, PENDING => "Pending", "Removed" => REMOVED}
  STATUS_UI_CLASS = {ACTIVE => "success", INACTIVE => "dark", PENDING => "warning", REMOVED => "danger"}
  STATUS_UI_ICON = {ACTIVE => "fa-check", INACTIVE => "fa-eye-slash", PENDING => "fa-clock-o", REMOVED => "fa-trash"}
  STATUS_UI_COLOR = {ACTIVE => "#63b94c", INACTIVE => "#4b4b4b", PENDING => "#FFCC00", REMOVED => "#ec407a"}

  included do

    validates :status, :presence=> true, :inclusion => {:in => STATUS_LIST.keys, :presence_of => :status, :message => "%{value} is not a valid status" }

    # Active
    def active?
      self.status == ACTIVE
    end

    def can_active?
      self.inactive? || self.removed?
    end

    def active!
      self.can_active? && self.update_attribute(:status, ACTIVE)
    end


    # Reject
    def inactive?
      self.status == INACTIVE
    end

    def can_inactive?
      self.active? || self.removed?
    end

    def inactive!
      self.can_inactive? && self.update_attribute(:status, INACTIVE)
    end


    # Pending
    def pending?
      self.status == PENDING
    end

    def can_pending?
      self.active? || self.removed?
    end

    def pending!
      self.can_pending? && self.update_attribute(:status, PENDING)
    end

    
    # Remove
    def removed?
      self.status == REMOVED
    end

    def can_remove?
      self.inactive? || self.active?
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
      when ACTIVE
        self.active!
      when INACTIVE
        self.inactive!
      when REMOVED
        self.remove!
      end
    end

    scope :activated, -> { where("#{table_name}": {status: ACTIVE} ) }
    scope :inactivated, -> { where("#{table_name}": {status: INACTIVE} ) }
    scope :removed, -> { where("#{table_name}": {status: REMOVED} ) }

    scope :status, lambda { |status| where("UPPER(#{table_name}.status)='#{status}'") }
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