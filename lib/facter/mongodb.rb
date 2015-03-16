Facter.add(:mongod_version) do
  confine :kernel => :linux
  setcode do
    version = Facter::Util::Resolution.exec('mongod --version')
    if version
      version.match(/\d+\.\d+\.\d+/).to_s
    else
      nil
    end
  end
end
