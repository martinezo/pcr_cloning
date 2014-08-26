# -*- coding: utf-8 -*-
class Requests::Cloning < ActiveRecord::Base
  validates :name, :sample_name, presence: true
  belongs_to :state, :class_name => 'Requests::State', :foreign_key => :inv_state_id
  validates :name, :payment_method, :sample_name, presence: true


  def self.search(search)
    if search
      where("(translate(lower(name),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou')\
            OR translate(lower(company),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou')\
            OR translate(lower(sample_name),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou'))",
            "%#{search}%","%#{search}%","%#{search}%")
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
