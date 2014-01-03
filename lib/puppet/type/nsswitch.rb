Puppet::Type.newtype(:nsswitch) do
  @doc = "Manage a Name Service Switch."

  ensurable

  newparam(:target) do
    desc "The file in which to store the settings."
  end

  newparam(:database) do
    isnamevar
    desc "The Name Service Database pertinent to the resource."
  end

  newparam(:service) do
    isnamevar
    desc "The name of the service to ensure."
  end

  newparam(:name) do
    desc "The name of the resource"
    munge do |name|
      @resource[:database] + ':' + @resource[:service]
    end
  end

  def self.title_patterns
    identity = lambda {|x| x}
    [ [ /^([^:]+)$/,
        [ [ :name, identity ] ]
    ],[ /^(.*):(.*)$/,
        [ [ :database, identity ],
          [ :service,  identity ] ]
    ] ]
  end

end
