class ZohoSubData < ApplicationRecord


  # Set Table Name
  self.table_name = "zoho_sub_datas"

  belongs_to :client_user
  # belongs_to :client_user
  belongs_to :subscription

end