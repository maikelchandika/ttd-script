# Helper script to generate package whitelist detail unique code

# How to use:
# - Change the start_number & end_number variable as your flavor
# - change the package_whitelist_id variable
# - on terminal run: ruby gen_package_whitelist_detail_mongodbs.rb

require 'SecureRandom'

start_number          = 10_001
end_number            = 20_000
package_whitelist_id  = '7a52ac674f12e551f6a4dd37'

# non mandatory customization
quota_order   = 99
quota_ticket  = 9
ids = {}

# skip process when nothing to generate
return if (start_number..end_number).size <= 0

# change this to avoid previous file append while generate a new one.
file_code = 2
File.open("3_package_whitelist_detail_#{file_code}.js", "a") do |f|
  f << "db.packageWhitelistDetail.insertMany([\n"
  (start_number..end_number).each do |i|
    # checking to ensure no generate id is duplicate
    id = SecureRandom.hex(12)
    while(ids.key?(id))
      id = SecureRandom.hex(12)
    end
    ids[id] = 1
    code = "CODE#{i.to_s.rjust(5, '0')}"
    obj1 = "\t{\"_id\": ObjectId(\"#{id}\"), \"code\": \"#{code}\", \"packageWhitelistId\": \"#{package_whitelist_id}\",\n"
    obj2 = "\t\"quotaOrder\": NumberLong(#{quota_order}),\"quotaTicket\": NumberLong(#{quota_ticket}),\"availabilityOrder\": NumberLong(#{quota_order}),\"availabilityTicket\": NumberLong(#{quota_ticket}),\"blockedOrder\": NumberLong(0),\"blockedTicket\": NumberLong(0),\"bookedOrder\": NumberLong(0),\"bookedTicket\": NumberLong(0),\"createdDate\" : ISODate(\"2022-07-28T19:15:50.900+07:00\"),\"updatedDate\" : ISODate(\"2022-07-28T19:15:50.900+07:00\"),\"isDeleted\": NumberLong(0),\"version\" : NumberLong(1)},\n"
    f << obj1; f << obj2;
    putc '.'
  end
  f << "])\n"
end
puts "\nDone generate #{(start_number..end_number).size}!"