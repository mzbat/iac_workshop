# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/lib/facter/homedirs.rb
# collect home directories
Facter.add(:homedirs) do
  confine :kernel => 'Linux'
  setcode do
    # grab home dirs on system and convert into array
   `ls /home`.split("\n")
  end
end 
