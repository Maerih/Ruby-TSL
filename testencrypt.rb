#Powered by Maerih.
#Free code.
#example of aes-256-cbc encryption for Ruby/Rails to encrypt URL params (or any text)

require 'openssl'
require 'base64'
require 'uri'


plaintext = 'id=example_id&user_id=the_user_id&username=voxtrot&user_first_name=john&user_last_name=doe&user_image=https://maerihn.netlify.app'

#
# Encrypt the plaintext string
#

cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
cipher.encrypt
key = cipher.key = cipher.random_key # stores the key in key, and also sets the generated key on the cipher
iv = cipher.iv = cipher.random_iv # stores the iv in iv, and also sets the generated iv on the cipher

# For documentation on cipher.final see http://www.ruby-doc.org/stdlib-1.9.3/libdoc/openssl/rdoc/OpenSSL/Cipher.html
encrypted = cipher.update(plaintext) + cipher.final
encrypted = Base64.urlsafe_encode64(encrypted)

# Write the key, iv, and encrypted text to files
File.open('key.txt', 'w') { |file| file.write(key) }
File.open('iv.txt', 'w') { |file| file.write(iv) }
File.open('new_encrypted.txt', 'w') { |file| file.write(encrypted) }

#
# Now decrypt
#

# Start with a new cipher
cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
cipher.decrypt
cipher.key = key
cipher.iv = iv

# Start the decryption
encrypted = Base64.urlsafe_decode64(encrypted)
decrypted = cipher.update(encrypted) + cipher.final

puts "------------------------------------Encryped-Parameters------------------------------------"
puts encrypted
puts "-------------------------------------------------------------------------------------------"
puts "\n"
puts "------------------------------------Decrypted------------------------------------"
puts "\n"
puts "\n"
puts decrypted
puts "---------------------------------------------------------------------------------"

