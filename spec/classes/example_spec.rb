require 'spec_helper'

describe 'virt_who' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "virt_who class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('virt_who::params') }
          it { is_expected.to contain_class('virt_who::install').that_comes_before('virt_who::config') }
          it { is_expected.to contain_class('virt_who::config') }
          it { is_expected.to contain_class('virt_who::service').that_subscribes_to('virt_who::config') }

          it { is_expected.to contain_service('virt_who') }
          it { is_expected.to contain_package('virt_who').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'virt_who class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('virt_who') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
