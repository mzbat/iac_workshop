# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/lib/facter/chkmnt.rb
Facter.add(:data_mnt_present) do
  setcode do
    if File.directory? '/data1'
      'yes'
    else
      'no'
    end
  end
end
