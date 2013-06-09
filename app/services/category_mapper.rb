# encoding: UTF-8

class CategoryMapper

  def self.map_category(hebrew_name)
    return nil if hebrew_name.blank?

    case hebrew_name.downcase.strip
      when 'אוכל ביתי' then 'Homemade'
      when 'בית קפה' then 'Cafe'
      when 'ביסטרו' then 'Bistro'
      when 'איטלקי' then 'Italian'
      when 'פיצריות' then 'Italian'
      when 'הודי' then 'Indian'
      when 'בשרים' then 'Meat'
      when 'המבורגר' then 'Meat'
      when 'ים תיכוני' then 'Middle Eastern'
      when 'חומוסיה' then 'Middle Eastern'
      when 'פלאפל' then 'Middle Eastern'
      when 'מזרחי' then 'Middle Eastern'
      when 'יפני' then 'Japanese'
      when 'סושי' then 'Japanese'
      when 'אסיאתי' then 'Asian'
      when 'אמריקאי' then 'American'
      when 'תאילנדי' then 'Asian'
      when 'סלטים' then 'Salad'
      when 'סנדוייצים' then 'Sandwich'
    end
  end

end