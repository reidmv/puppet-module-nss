Puppet::Type.newtype(:nsswitch) do
  @doc = "Manage a Name Service Switch."

  ensurable

  newparam(:database) do
    isrequired
    desc "The Name Service Database pertinent to the resource."
  end

  newproperty(:service) do
    isnamevar
    desc "The name of the service to ensure."
  end

  newproperty(:reaction, :array_matching => :all) do
    desc "The reaction on lookup result (like NOTFOUND=return)."
  end

end
