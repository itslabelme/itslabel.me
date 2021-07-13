class DataCorrectionJune22 < ActiveRecord::Migration[5.2]
  def change
    ClientUser.update_all("t_c_accepted = true")

  end
end
