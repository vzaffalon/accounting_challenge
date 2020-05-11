class AccountTransferSerializer < ActiveModel::Serializer
    attributes :id, :amount, :source_account, :destination_account


    belongs_to :source_account, class_name: 'Account'
    belongs_to :destination_account, class_name: 'Account'
  
  end
