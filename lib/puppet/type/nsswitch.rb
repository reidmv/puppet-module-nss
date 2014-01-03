Puppet::Type.newtype(:nsswitch) do
  @doc = "Manage a Name Service Switch."

  ensurable

  newparam(:database) do
    isnamevar
    desc "The Name Service Database pertinent to the resource."
  end

  newparam(:target) do
    desc "The file in which to store the settings."
  end

  newproperty(:service) do
    isnamevar
    desc "The name of the service to ensure."
  end

  newproperty(:reaction, :array_matching => :all) do
    desc "The reaction on lookup result (like NOTFOUND=return)."
  end

  def self.title_patterns
    identity = lambda {|x| x}
    [ [
        /^([^:]+)$/,
        [ [ :name, identity ] ]
    ],[
        /^(.*):(.*)$/,
        [ [ :database, identity ],
          [ :service,  identity ] ]
    ] ]
  end

end
