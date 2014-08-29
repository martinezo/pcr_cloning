# -*- coding: utf-8 -*-
class Requests::Cloning < ActiveRecord::Base
  belongs_to :state, :class_name => 'Requests::State', :foreign_key => :inv_state_id
  validates :name, :company, :mail,
            :sample_name, :sample_volume, :pcr_product_size, :group_leader, :payment_method, :type, presence: true


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

end
