module Itslabel::Permissions::TranslationPermissions
  
  extend ActiveSupport::Concern

	# Permission Methods
  # ------------------

  def can_be_edited?
    active? || inactive? || pending?
  end

  def can_be_edited_by_admin?
    active? || inactive? || pending?
    # !(removed? || cancelled?)
  end

  def can_be_deleted?
    inactive? || pending?
  end
  
end