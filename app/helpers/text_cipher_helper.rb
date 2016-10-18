module TextCipherHelper
  def self.encrypt(text_to_encript)
    pass = "some hopefully not to easily guessable password"
    salt = "keypassphrase"
    iter = 20000
    key_len = 16
    key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass, salt, iter, key_len)
    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    cipher.encrypt
    cipher.key = key
    cipher.iv = key
    encrypted = cipher.update(text_to_encript) + cipher.final
  end

  def self.decrypt(text_to_decipher)
    pass = "some hopefully not to easily guessable password"
    salt = "keypassphrase"
    iter = 20000
    key_len = 16
    key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass, salt, iter, key_len)
    decipher = OpenSSL::Cipher::AES.new(128, :CBC)
    decipher.decrypt
    decipher.key = key
    decipher.iv = key
    plain = decipher.update(text_to_decipher) + decipher.final
  end
end
