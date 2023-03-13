require 'openssl'
require 'digest'

hash_data = "zero2hero+"
nonce = 0
hash = ""

until hash.start_with?("0000")
  nonce += 1
  hash = Digest::SHA256.hexdigest("#{hash_data}#{nonce}")
end

puts "The SHA256 hash with 4 leading zeroes is: #{hash}"
puts "The input value is: #{hash_data}#{nonce}"
