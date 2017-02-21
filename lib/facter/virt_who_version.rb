Facter.add(:virt_who_version) do
  setcode do
    if Facter::Util::Resolution.which('virt-who')
      if Facter::Util::Resolution.which('rpm')
        begin
          Facter::Core::Execution.execute('rpm -q --qf "%{VERSION}-%{RELEASE}\n" virt-who 2>&1', :timeout => 10)
        rescue Facter::Core::Execution::ExecutionFailure
          'rpm timeout, maybe broken rpmdb'
        end
      end
    end
  end
end
