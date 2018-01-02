Facter.add(:role) do
  # Retrieve hostname and assign role base on it        
  setcode do
    hname = Facter.value(:hostname)
    case hname
    when /^airlock/
      'airlock'
    else
      'iac_node'
    end
  end
end
