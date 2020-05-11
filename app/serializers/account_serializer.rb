class AccountSerializer < ActiveModel::Serializer
    attributes :id, :name, :amount, :available_amount, :number


    belongs_to :user
    has_many :account_transactions

    def available_amount
        object.available_amount
    end
  
  end
  