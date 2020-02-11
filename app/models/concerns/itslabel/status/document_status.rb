module Itslabel::Status::DocumentStatus
  
  extend ActiveSupport::Concern

  # Constants
  ACTIVE = "ACTIVE"
  REMOVED = "REMOVED"
  ARCHIVED = "ARCHIVED"
  
  STATUS_LIST = {ACTIVE => "Active", REMOVED => "Removed", ARCHIVED => "Archived"}
  REVERSED_STATUS_LIST = {"Active" => ACTIVE, "Removed" => REMOVED, "Archived" => ARCHIVED}
  STATUS_UI_CLASS = {ACTIVE => "active", REMOVED => "removed", ARCHIVED => "archived"}
  STATUS_UI_ICON = {ACTIVE => "fa-check", REMOVED => "fa-trash", ARCHIVED => "fa-archive"}
  STATUS_UI_COLOR = {ACTIVE => "#63b94c", REMOVED => "#ec407a", ARCHIVED => "#898989"}

  included do

    validates :status, :presence=> true, :inclusion => {:in => STATUS_LIST.keys, :presence_of => :status, :message => "%{value} is not a valid status" }

    # Active
    def active?
      self.status == ACTIVE
    end

    def can_active?
      !active?
    end

    def active!
      self.can_active? && self.update_attribute(:status, ACTIVE)
    end


    # Remove
    def removed?
      self.status == REMOVED
    end

    def can_remove?
      !removed?
    end

    def remove!
      self.can_remove? && self.update_attribute(:status, REMOVED)
    end


    # Archive
    def archived?
      self.status == ARCHIVED
    end

    def can_archive?
      self.active?
    end

    def archive!
      self.can_archive? && self.update_attribute(:status, ARCHIVED)
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
        self.active! if self.can_active?
      when REMOVED
        self.remove! if self.can_remove?
      when ARCHIVED
        self.archive! if self.can_archive?
      end
    end

    scope :activated, -> { where("#{table_name}": {status: ACTIVE} ) }
    scope :removed, -> { where("#{table_name}": {status: REMOVED} ) }
    scope :archived, -> { where("#{table_name}": {status: ARCHIVED} ) }

    scope :status, lambda { |status| where("UPPER(#{table_name}.status)='#{status}'") }
    scope :all_statuses_expect, lambda { |status| where("UPPER(#{table_name}.status) NOT IN (?)", status) }
    scope :any_of_the_statuses, lambda { |status| where("UPPER(#{table_name}.status) IN (?)", status) }
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