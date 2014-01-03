require 'puppetx/augeasprovider/provider'

Puppet::Type.type(:nsswitch).provide(:augeas) do
  desc "Uses Augeas to manage Name Service Switch configuration file"

  include PuppetX::AugeasProvider::Provider
  default_file  { '/etc/nsswitch.conf' }
  lens          { 'Nsswitch.lns'       }
  resource_path do |resource|
    "$target/database[.='#{resource[:database]}']"
  end

  confine    :feature => :augeas
  defaultfor :feature => :augeas

  def self.instances
    resources = []
    augopen do |aug|
      aug.match('$target/database').each do |dpath|
        aug.defvar('resource', dpath)
        database = aug.get(dpath)
        aug.match("$target/database[.='#{database}']/service").each do |spath|
          aug.defvar('resource', spath)
          service = aug.get(spath)
          name = database + ':' + service
          resources << new({
            :name     => name,
            :service  => service,
            :database => database
          })
        end
      end
    end
    resources
  end

end
