module Itslabel::Permissions::DocumentPermissions
  
  extend ActiveSupport::Concern

	# Permission Methods
  # ------------------

  def can_be_edited?
    !removed?
  end

  # FIXME - Do not allow to delete a translation if it is being used in any of the document
  def can_be_deleted?
    true
    # removed?
  end
  
end