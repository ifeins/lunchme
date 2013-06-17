# encoding: UTF-8

class CuisineMapper

  def self.map_cuisine(hebrew_name)
    return nil if hebrew_name.blank?

    case hebrew_name.downcase.strip
      when 'אוכל ביתי' then 'Homemade'
      when 'בית קפה' then 'Cafe'
      when 'ביסטרו' then 'Bistro'
      when 'איטלקי' then 'Italian'
      when 'פיצריות' then 'Pizzeria'
      when 'הודי' then 'Indian'
      when 'בשרים' then 'Meat'
      when 'אמריקאי' then 'American'
      when 'המבורגר' then 'Hamburger'
      when 'ים תיכוני' then 'Middle Eastern'
      when 'פלאפל' then 'Middle Eastern'
      when 'מזרחי' then 'Middle Eastern'
      when 'חומוסיה' then 'Hummus'
      when 'אסיאתי' then 'Asian'
      when 'יפני' then 'Japanese'
      when 'תאילנדי' then 'Thai food'
      when 'סושי' then 'Sushi'
      when 'סלטים' then 'Salad'
      when 'סנדוייצים' then 'Sandwich'
    end
  end

end