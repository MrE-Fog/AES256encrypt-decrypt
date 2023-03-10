require 'openssl'
require 'base64'
require 'digest'

# Исходные данные:
key_data = File.binread('key_file')

data = File.binread('plain_text')

#For AES-256-CBC 
cipher = OpenSSL::Cipher::AES256.new:CBC 
# or cipher = OpenSSL::Cipher.new('aes-256-cbc')

cipher.encrypt

# Setting key:
key = Digest::SHA256.digest(key_data)

iv = cipher.random_iv

cipher.key = key

encrypted = cipher.update(data) + cipher.final

encrypted = Base64.strict_encode64(encrypted)

#Сохраняем в файлы:
File.open('key.txt', 'w') { |file| file.write(key) }

File.open('iv.txt', 'w') { |file| file.write(iv) }

File.open('new_encrypted.txt', 'w') { |file| file.write(encrypted) }

# Start with a new cipher
cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")

cipher.decrypt

cipher.key = key

cipher.iv = iv

# Start the decryption
encrypted = Base64.strict_decode64(encrypted)

decrypted = cipher.update(encrypted) + cipher.final


puts "Decrypted..."
puts decrypted
