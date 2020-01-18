module Itslabel::Permissions::AdminUserPermissions
  
  extend ActiveSupport::Concern

	# Permission Methods
  # ------------------

  def can_be_edited?
    true
  end

  # FIXME - Do not allow to delete a translation if it is being used in any of the document
  def can_be_deleted?
    true
  end
  
end