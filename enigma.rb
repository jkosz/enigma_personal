require_relative 'crypt'
require_relative 'encrypt'
require_relative 'decrypt'

class Enigma
  # METAPROGRAMMING_MAP = ("a".."b").to_a

  def encrypt(message=nil, key=nil, date=nil)
    Encrypt.new(message, key, date).encrypted_message
  end

  def decrypt(message=nil, key=nil, date=nil)
    Decrypt.new(message, key, date).decrypted_message
  end
end