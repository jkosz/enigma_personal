require_relative 'crypt'

class Decrypt
  include ::Crypt

  def character_map
    (("a".."z").to_a + ("0".."9").to_a + [" ", ".", ","]).reverse!
  end

  def initialize(message, key=nil, date=nil)
    @message = message
    @key = verify_key(key)
    @date = verify_date(date)
  end

  def decrypted_message
    iterate_over_message_and_replace_characters
  end
end