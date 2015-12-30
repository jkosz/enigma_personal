require 'date'

module Crypt
  DATE_LENGTH_ERROR = "Length of date supplied is invalid. Please supply a date that is six digits in length"
  KEY_LENGTH_ERROR = "Length of key supplied is invalid.  Please supply a key that is five characters in length"

  attr_reader :key, :date
  attr_accessor :message

  def self.date
    Date.today.strftime("%d%m%y").to_i
  end

  def self.key
    "12345"
  end

  def verify_date(date=nil)
    date = Crypt.date unless date

    if date.to_s.length == 6
      @date = date.to_i
    else
      raise DATE_LENGTH_ERROR
    end
  end

  def verify_key(key=nil)
    key = Crypt.key unless key

    if key.to_s.length == 5
       @key = key
     else
      raise KEY_LENGTH_ERROR
    end
  end

  # def rotations_from_key
    # METAPROGRAMMING_MAP.each_with_index do |char, index|
    #   define_method("@rotation_#{char}=") do
    #     key.slice((index)..(index+1))
    #   end
    # end
    # (0..3).to_a.map do |index|
    #   key.slice((index)..(index+1))
    # end
    # @rotation_a = key.slice(0..1)
    # @rotation_b = key.slice(1..2)
    # @rotation_c = key.slice(2..3)
    # @rotation_d = key.slice(3..4)
    #[@rotation_a, @rotation_b, @rotation_c, @rotation_d]
  # end

  # def offsets_from_date
  #   base = (date ** 2).to_s[-4..-1]
  #   (0..3).to_a.map do |index|
  #     base[index]
  #   end
    # @offset_a = base[0]
    # @offset_b = base[1]
    # @offset_c = base[2]
    # @offset_d = base[3]
    #[@offset_a, @offset_b, @offset_c, @offset_d]
  # end

  def offsets
    base = (date ** 2).to_s[-4..-1]
    @offsets ||= (0..3).to_a.map do |index|
      base[index]
    end
  end

  def rotations
    @rotations ||= (0..3).to_a.map do |index|
      key.slice((index)..(index+1))
    end
  end

  def total_offset(group_position)
    (rotations[group_position].to_i + offsets[group_position].to_i)
  end

  def split_message(message)
    @split_message ||= message.split(//)
  end

  def character_position(character)
    # character_map defined by constant in Decrypt and Encrypt classes
    @character_position = character_map.find_index(character)
  end

  def new_character(character, position)
    # character_map defined by constant in Decrypt and Encrypt classes
    character_map[(character_position(character) + total_offset(position)) % 39]
  end

  def iterate_over_message_and_replace_characters
    split_message(@message).each_with_index.inject([]) do |output, (char, index)|
      output << new_character(char, index%4)
    end.join
  end
end