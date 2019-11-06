# This file was automatically generated on 2019-10-08 15:30:46 -0700.
# Use the 'puppet generate types' command to regenerate this file.

# Manages registry keys on Windows systems.
# 
# Keys within HKEY_LOCAL_MACHINE (hklm) or HKEY_CLASSES_ROOT (hkcr) are
# supported.  Other predefined root keys, e.g. HKEY_USERS, are not
# currently supported.
# 
# If Puppet creates a registry key, Windows will automatically create any
# necessary parent registry keys that do not exist.
# 
# Puppet will not recursively delete registry keys.
# 
# **Autorequires:** Any parent registry key managed by Puppet will be
# autorequired.
Puppet::Resource::ResourceType3.new(
  'registry_key',
  [
    # The basic property that the resource should be in.
    # 
    # Valid values are `present`, `absent`.
    Puppet::Resource::Param(Enum['present', 'absent'], 'ensure')
  ],
  [
    # The path to the registry key to manage.  For example; 'HKLMSoftware',
    # 'HKEY_LOCAL_MACHINESoftwareVendor'.  If Puppet is running on a 64-bit
    # system, the 32-bit registry key can be explicitly managed using a
    # prefix.  For example: '32:HKLMSoftware'
    Puppet::Resource::Param(Any, 'path', true),

    # Whether to delete any registry value associated with this key that is
    # not being managed by puppet.
    # 
    # Valid values are `true`, `false`.
    Puppet::Resource::Param(Variant[Boolean, Enum['true', 'false']], 'purge_values'),

    # The specific backend to use for this `registry_key`
    # resource. You will seldom need to specify this --- Puppet will usually
    # discover the appropriate provider for your platform.Available providers are:
    # 
    # registry
    # : * Default for `operatingsystem` == `windows`.
    Puppet::Resource::Param(Any, 'provider')
  ],
  {
    /(?m-ix:^(.*?)\Z)/ => ['path']
  },
  true,
  false)
