# -*- coding: utf-8 -*-
class Requests::Cloning < ActiveRecord::Base


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


end
