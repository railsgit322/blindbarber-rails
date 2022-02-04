class Address < ApplicationRecord
  belongs_to :user, required: true

  after_commit :reset_default, if: :is_default?

  def cust_name
    "#{user.first_name} #{user.last_name}"
  end
  
  protected
   def reset_default
     self.class.where.not(id: id).where(is_default: true).update_all(is_default: false)
   end

end
