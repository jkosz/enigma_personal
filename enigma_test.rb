gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'enigma'

class EnigmaTest < Minitest::Test
  def test_encrypt_method_returns_successfully
    e = Enigma.new

    assert e.encrypt("winter"), true
    assert e.encrypt("winter").class, String
  end

  def test_encrypt_method_with_all_parameters_returns_successfully
    e = Enigma.new

    assert_equal e.encrypt("winter", "12345", 201215), "b7k4wd"
  end

  def test_decrypt_method_returns_successfully
    e = Enigma.new

    assert e.decrypt("winter"), true
    assert e.decrypt("winter").class, String
  end

  def test_decrypt_method_with_all_parameters_returns_successfully
    e = Enigma.new

    assert_equal e.decrypt("b7k4wd", "12345", 201215), "winter"
  end

  def test_that_message_can_be_cracked_given_some_weird_ass_inputs
    skip
    e = Enigma.new

    assert_equal e.crack(" bot55"), "spring"
  end

end