class Page < ActiveRecord::Base
  attr_accessible :parent_id, :content, :name
  
  validates :slug, uniqueness: true, presence: true,
                   exclusion: {in: %w[signup login]}
  
  before_validation :generate_slug
  
  has_ancestry
  
  def to_param
    slug
  end
  
  def generate_slug
    self.slug ||= name.parameterize
  end
  #implementing the Luhn algorithm
  def find_checksum(card_number)
    number_arr = card_number.to_s.reverse.scan(/\d/).map { |x| x.to_i }
    number_arr = number_arr.each_with_index.map { |d, i|
      d *= 2 if i.even?
      d > 9 ? d - 9 : d
    }
    sum = number_arr.inject(0) { |m, x| m + x }
    mod = 10 - sum % 10
    mod==10 ? 0 : mod
  end
 
  def check_card_number(card_number)
    find_checksum(card_number) == 0
  end
   
  def final_card_number(card_number)
    card_number = card_number.to_s
    checksum_digit = find_checksum(card_number).to_s
    card_number.ljust(card_number.length+1, checksum_digit)
  end

end
