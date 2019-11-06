# This file was automatically generated on 2019-10-08 15:30:46 -0700.
# Use the 'puppet generate types' command to regenerate this file.

# Manages registry values on Windows systems.
# 
# The `registry_value` type can manage registry values.  See the
# `type` and `data` attributes for information about supported
# registry types, e.g. REG_SZ, and how the data should be specified.
# 
# **Autorequires:** Any parent registry key managed by Puppet will be
# autorequired.
Puppet::Resource::ResourceType3.new(
  'registry_value',
  [
    # The basic property that the resource should be in.
    # 
    # Valid values are `present`, `absent`.
    Puppet::Resource::Param(Enum['present', 'absent'], 'ensure'),

    # The Windows data type of the registry value.  Puppet provides
    # helpful names for these types as follows:
    # 
    # * string => REG_SZ
    # * array  => REG_MULTI_SZ
    # * expand => REG_EXPAND_SZ
    # * dword  => REG_DWORD
    # * qword  => REG_QWORD
    # * binary => REG_BINARY
    # 
    # Valid values are `string`, `array`, `dword`, `qword`, `binary`, `expand`.
    Puppet::Resource::Param(Enum['string', 'array', 'dword', 'qword', 'binary', 'expand'], 'type'),

    # The data stored in the registry value.  Data should be specified
    # as a string value but may be specified as a Puppet array when the
    # type is set to `array`.
    Puppet::Resource::Param(Any, 'data')
  ],
  [
    # The path to the registry value to manage.  For example:
    # 'HKLMSoftwareValue1', 'HKEY_LOCAL_MACHINESoftwareVendorValue2'.
    # If Puppet is running on a 64-bit system, the 32-bit registry key can
    # be explicitly managed using a prefix.  For example:
    # '32:HKLMSoftwareValue3'. Use a double backslash between the value name
    # and path when managing a value with a backslash in the name.
    Puppet::Resource::Param(Any, 'path', true),

    # The specific backend to use for this `registry_value`
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
