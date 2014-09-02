# -*- coding: utf-8 -*-
class Requests::Cloning < ActiveRecord::Base
  belongs_to :state, :class_name => 'Requests::State', :foreign_key => :inv_state_id
  validates :name, :company, :mail,
            :sample_name, :sample_volume, :pcr_product_size, :group_leader, :payment_method, :req_type, presence: true

  before_validation :set_price

  def set_price
    Admin::SystemConfig.get
    if self.payment_method < 4
      self.price = Admin::SystemConfig.internal_price
    else
      self.price = Admin::SystemConfig.external_price
    end
  end

  def self.search(search)
    if search
      where("(translate(lower(name),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou')\
            OR translate(lower(sample_name),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou'))",
            "%#{search}%","%#{search}%")
    else
      all
    end
  end

   PMT_METHOD = {
      1 => 'UR',
      2 => 'Conacyt',
      3 => 'PAPIIT',
      4 => 'Efectivo',
      5 => 'Depósito bancario'
   }

   TYPE ={
       1 => 'Clonación Sencilla',
       2 => 'Clonación y Secuenciación'
   }

   SEQ_TYPE ={
       1 => 'Forward',
       2 => 'Reverse',
       3 => 'Ambos'
   }

end
