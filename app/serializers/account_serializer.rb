class AccountSerializer < ActiveModel::Serializer
    attributes :id, :name, :amount, :available_amount


    belongs_to :user

    def available_amount
        object.available_amount
    end
  
  end
  