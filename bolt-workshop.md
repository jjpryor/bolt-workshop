# Bolt Workshop

[slides](http://bit.ly/2LWK1lE)


[Get Windows Key at http://bit.ly/B0ltk3y](http://bit.ly/B0ltk3y) and Linux SSH key at [http://bit.ly/B0lts5h](http://bit.ly/B0lts5h)

* Windows
  * `bolt-pdxwin27.classroom.puppet.com`
* Linux:
  * `bolt-pdxnix27.classroom.puppet.com`
* Puppet Master
  * `bolt-pdxmaster.classroom.puppet.com`

* Windows
  * username: `puppetinstructor`
  * password: `@Pupp3t1abs`

My number: `27`

## Lab 2

Run a ping command against each group, then a common command against both groups.

```shell
$ bolt command run 'ping 8.8.8.8 -c 2' --nodes bolt-pdxnix27.classroom.puppet.com --user centos --private-key ~jpryor/Documents/bolt-workshop/student.pem  --no-host-key-check
Started on bolt-pdxnix27.classroom.puppet.com...
Finished on bolt-pdxnix27.classroom.puppet.com:
  STDOUT:
    PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
    64 bytes from 8.8.8.8: icmp_seq=1 ttl=44 time=7.28 ms
    64 bytes from 8.8.8.8: icmp_seq=2 ttl=44 time=7.33 ms

    --- 8.8.8.8 ping statistics ---
    2 packets transmitted, 2 received, 0% packet loss, time 1001ms
    rtt min/avg/max/mdev = 7.280/7.306/7.332/0.026 ms
Successful on 1 node: bolt-pdxnix27.classroom.puppet.com
Ran on 1 node in 1.93 sec
$ bolt command run 'ping 8.8.8.8' --nodes bolt-pdxwin27.classroom.puppet.com --user puppetinstructor --pass '@Pupp3t1abs' --transport winrm --no-sslStarted on bolt-pdxwin27.classroom.puppet.com...
Finished on bolt-pdxwin27.classroom.puppet.com:
  STDOUT:

    Pinging 8.8.8.8 with 32 bytes of data:
    Reply from 8.8.8.8: bytes=32 time=8ms TTL=43
    Reply from 8.8.8.8: bytes=32 time=8ms TTL=43
    Reply from 8.8.8.8: bytes=32 time=8ms TTL=43
    Reply from 8.8.8.8: bytes=32 time=8ms TTL=43

    Ping statistics for 8.8.8.8:
        Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
    Approximate round trip times in milli-seconds:
        Minimum = 8ms, Maximum = 8ms, Average = 8ms
Successful on 1 node: bolt-pdxwin27.classroom.puppet.com
Ran on 1 node in 4.09 sec
```

## Lab 3

Use bolt with `bolt.yaml`, so add a `bolt.yaml` file to config bolt to use default options

```shell
mkdir bolt-workshop
cd bolt-workshop
vim bolt.yaml
```

```yaml
---
ssh:
  host-key-check: false
winrm:
  ssl: false
```

Now it uses the `bolt.yaml` config file defaults

```shell
$ bolt command run 'ping 8.8.8.8' --nodes bolt-pdxwin27.classroom.puppet.com --user puppetinstructor --pass '@Pupp3t1abs' --transport winrm
Started on bolt-pdxwin27.classroom.puppet.com...
Finished on bolt-pdxwin27.classroom.puppet.com:
  STDOUT:

    Pinging 8.8.8.8 with 32 bytes of data:
    Reply from 8.8.8.8: bytes=32 time=8ms TTL=42
    Reply from 8.8.8.8: bytes=32 time=7ms TTL=42
    Reply from 8.8.8.8: bytes=32 time=7ms TTL=42
    Reply from 8.8.8.8: bytes=32 time=7ms TTL=42

    Ping statistics for 8.8.8.8:
        Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
    Approximate round trip times in milli-seconds:
        Minimum = 7ms, Maximum = 8ms, Average = 7ms
Successful on 1 node: bolt-pdxwin27.classroom.puppet.com
Ran on 1 node in 4.09 sec
```

## Lab 4

Create a inventory file `inventory.yaml` in the `bolt-workshop directory.

```yaml
---
groups:
  - name: linux
    nodes:
      - bolt-pdxnix27.classroom.puppet.com
    config:
      transport: ssh
      ssh:
        host-key-check: false
        user: centos
        run-as: root
        private-key: /home/jpryor/Documents/bolt-workshop/student.pem
  - name: windows
    nodes:
      - bolt-pdxwin27.classroom.puppet.com
    config:
      transport: winrm
      winrm:
        user: puppetinstructor
        password: "@Pupp3t1abs"
        ssl: false
```

## Lab 5

Use inventory file

```shell
$ bolt command run 'ping 8.8.8.8 -c 2' --nodes linux
Started on bolt-pdxnix27.classroom.puppet.com...
Finished on bolt-pdxnix27.classroom.puppet.com:
  STDOUT:
    PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
    64 bytes from 8.8.8.8: icmp_seq=1 ttl=43 time=7.14 ms
    64 bytes from 8.8.8.8: icmp_seq=2 ttl=43 time=7.11 ms

    --- 8.8.8.8 ping statistics ---
    2 packets transmitted, 2 received, 0% packet loss, time 1001ms
    rtt min/avg/max/mdev = 7.113/7.129/7.145/0.016 ms
Successful on 1 node: bolt-pdxnix27.classroom.puppet.com
Ran on 1 node in 1.92 sec
$ bolt command run 'ping 8.8.8.8 -n 2' --nodes windows
Started on bolt-pdxwin27.classroom.puppet.com...
Finished on bolt-pdxwin27.classroom.puppet.com:
  STDOUT:

    Pinging 8.8.8.8 with 32 bytes of data:
    Reply from 8.8.8.8: bytes=32 time=6ms TTL=43
    Reply from 8.8.8.8: bytes=32 time=7ms TTL=43

    Ping statistics for 8.8.8.8:
        Packets: Sent = 2, Received = 2, Lost = 0 (0% loss),
    Approximate round trip times in milli-seconds:
        Minimum = 6ms, Maximum = 7ms, Average = 6ms
Successful on 1 node: bolt-pdxwin27.classroom.puppet.com
Ran on 1 node in 2.03 sec

$ bolt command run 'hostname' --nodes linux,windows
Started on bolt-pdxnix27.classroom.puppet.com...
Started on bolt-pdxwin27.classroom.puppet.com...
Finished on bolt-pdxnix27.classroom.puppet.com:
  STDOUT:
    bolt-pdxnix27.classroom.puppet.com
Finished on bolt-pdxwin27.classroom.puppet.com:
  STDOUT:
    EC2AMAZ-HE0EQDB
Successful on 2 nodes: bolt-pdxnix27.classroom.puppet.com,bolt-pdxwin27.classroom.puppet.com
Ran on 2 nodes in 0.98 sec
```

## Boltdir

`bolt` can use a `Boltdir` to assist in packaging with source code. When bolt sees a directory called `Boltdir` it will overrides all other configuration and then read from this directory for configs and inventories.

## Lab 6

Run a script

```shell
$ mkdir seteam
$ cd seteam/
$ git clone https://github.com/puppetlabs-seteam/bolt-timesync.git
Cloning into 'bolt-timesync'...
remote: Enumerating objects: 185, done.
remote: Total 185 (delta 0), reused 0 (delta 0), pack-reused 185
Receiving objects: 100% (185/185), 37.68 KiB | 1.71 MiB/s, done.
Resolving deltas: 100% (53/53), done.
$ cd ..
$ cp seteam/bolt-timesync/timesync.ps1
$ bolt script run timesync.ps1 --nodes windows
Started on bolt-pdxwin27.classroom.puppet.com...
Finished on bolt-pdxwin27.classroom.puppet.com:
  STDOUT:
    Reconfiguring W32Time...
    The command completed successfully.

    Resyncing clock...
    Sending resync command to local computer
    The command completed successfully.

    Current time source:
    1.nl.pool.ntp.org

    All configured time sources:
    #Peers: 5

    Peer: 0.nl.pool.ntp.org
    State: Active
    Time Remaining: 0.8273433s
    Mode: 3 (Client)
    Stratum: 0 (unspecified)
    PeerPoll Interval: 0 (unspecified)
    HostPoll Interval: 9 (512s)

    Peer: 0.nl.pool.ntp.org
    State: Active
    Time Remaining: 511.8589615s
    Mode: 3 (Client)
    Stratum: 0 (unspecified)
    PeerPoll Interval: 0 (unspecified)
    HostPoll Interval: 9 (512s)

    Peer: 0.nl.pool.ntp.org
    State: Active
    Time Remaining: 511.9683246s
    Mode: 3 (Client)
    Stratum: 0 (unspecified)
    PeerPoll Interval: 0 (unspecified)
    HostPoll Interval: 9 (512s)

    Peer: 0.nl.pool.ntp.org
    State: Active
    Time Remaining: 0.0682320s
    Mode: 3 (Client)
    Stratum: 0 (unspecified)
    PeerPoll Interval: 0 (unspecified)
    HostPoll Interval: 17 (out of valid range)

    Peer: 1.nl.pool.ntp.org
    State: Active
    Time Remaining: 511.9214373s
    Mode: 3 (Client)
    Stratum: 2 (secondary reference - syncd by (S)NTP)
    PeerPoll Interval: 17 (out of valid range)
    HostPoll Interval: 9 (512s)
Successful on 1 node: bolt-pdxwin27.classroom.puppet.com
Ran on 1 node in 2.6 sec
```

## Lab 7

Make a script into a task

```shell
$ mkdir -p Boltdir/modules/tools/tasks
$ mv timesync.ps1 Boltdir/modules/tools/tasks/
0$ bolt tasks show
$ bolt task show
azure_inventory::resolve_reference   Generate targets from Azure VMs
facts                                Gather system facts
package                              Manage and inspect the state of packages
puppet_agent::install                Install the Puppet agent package
puppet_agent::version                Get the version of the Puppet agent package installed. Returns nothing if none present.
puppet_conf                          Inspect puppet agent configuration settings
reboot                               Reboots a machine
reboot::last_boot_time               Gets the last boot time of a Linux or Windows system
service                              Manage and inspect the state of services
tools::timesync

MODULEPATH:
/home/jpryor/Documents/bolt-workshop/Boltdir/modules:/home/jpryor/Documents/bolt-workshop/Boltdir/site-modules:/home/jpryor/Documents/bolt-workshop/Boltdir/site

Use `bolt task show <task-name>` to view details and parameters for a specific task.
02:24:49 jpryor@localhost ~/Documents/bolt-workshop $ bolt task run tools::timesync --nodes windows
Started on bolt-pdxwin27.classroom.puppet.com...
Finished on bolt-pdxwin27.classroom.puppet.com:
  Reconfiguring W32Time...
  The command completed successfully.
  
  Resyncing clock...
  Sending resync command to local computer
  The command completed successfully.
  
  Current time source:
  0.nl.pool.ntp.org
  
  All configured time sources:
  #Peers: 2
  
  Peer: 0.nl.pool.ntp.org
  State: Active
  Time Remaining: 511.7685710s
  Mode: 3 (Client)
  Stratum: 1 (primary reference - syncd by radio clock)
  PeerPoll Interval: 9 (512s)
  HostPoll Interval: 9 (512s)
  
  Peer: 1.nl.pool.ntp.org
  State: Active
  Time Remaining: 511.7686125s
  Mode: 3 (Client)
  Stratum: 0 (unspecified)
  PeerPoll Interval: 17 (out of valid range)
  HostPoll Interval: 9 (512s)
  {
  }
Successful on 1 node: bolt-pdxwin27.classroom.puppet.com
Ran on 1 node in 4.23 sec
```

## Lab 8

Add metadata to task

```ps1
# timesync.ps1
[CmdletBinding()]
Param(
  [Parameter(Mandatory = $True)] [Boolean] $Restart
)

echo "Reconfiguring W32Time..."
w32tm /config /syncfromflags:MANUAL /manualpeerlist:"0.nl.pool.ntp.org 1.nl.pool.ntp.org" /update
echo ""
echo "Resyncing clock..."
w32tm /resync
echo ""
echo "Current time source:"
w32tm /query /source
echo ""
echo "All configured time sources:"
w32tm /query /peers

if ($Restart) {
    write-host "Restart parameter enabled, restarting Windows Time service"
    restart-service 'W32Time' -force
    write-host "Windows Time service restarted"
}
```

* `timesync.json`

```json
{
  "description": "Configures Windows Time via powershell",
  "input_method": "powershell",
  "parameters": {
    "restart": {
      "description": "Restart the service after configuration",
      "type": "Boolean"
    }
  }
}
```

Then see the details with `bolt task show`

```shell
$ bolt task show
azure_inventory::resolve_reference   Generate targets from Azure VMs
facts                                Gather system facts
package                              Manage and inspect the state of packages
puppet_agent::install                Install the Puppet agent package
puppet_agent::version                Get the version of the Puppet agent package installed. Returns nothing if none present.
puppet_conf                          Inspect puppet agent configuration settings
reboot                               Reboots a machine
reboot::last_boot_time               Gets the last boot time of a Linux or Windows system
service                              Manage and inspect the state of services
tools::timesync                      Configures Windows Time via powershell

MODULEPATH:
/home/jpryor/Documents/bolt-workshop/Boltdir/modules:/home/jpryor/Documents/bolt-workshop/Boltdir/site-modules:/home/jpryor/Documents/bolt-workshop/Boltdir/site

Use `bolt task show <task-name>` to view details and parameters for a specific task.
$ bolt task show tools::timesync

tools::timesync - Configures Windows Time via powershell

USAGE:
bolt task run --nodes <node-name> tools::timesync restart=<value>

PARAMETERS:
- restart: Boolean
    Restart the service after configuration

MODULE:
/home/jpryor/Documents/bolt-workshop/Boltdir/modules/tools
```

Run it
```shell
$ bolt task run tools::timesync --nodes windows
Task tools::timesync:
 expects a value for parameter 'restart'
$ bolt task run tools::timesync --nodes windows restart=true
Started on bolt-pdxwin27.classroom.puppet.com...
Finished on bolt-pdxwin27.classroom.puppet.com:
  Reconfiguring W32Time...
  The command completed successfully.
  
  Resyncing clock...
  Sending resync command to local computer
  The command completed successfully.
  
  Current time source:
  1.nl.pool.ntp.org
  
  All configured time sources:
  #Peers: 2
  
  Peer: 0.nl.pool.ntp.org
  State: Active
  Time Remaining: 511.7829419s
  Mode: 3 (Client)
  Stratum: 1 (primary reference - syncd by radio clock)
  PeerPoll Interval: 9 (512s)
  HostPoll Interval: 9 (512s)
  
  Peer: 1.nl.pool.ntp.org
  State: Active
  Time Remaining: 511.7829594s
  Mode: 3 (Client)
  Stratum: 1 (primary reference - syncd by radio clock)
  PeerPoll Interval: 9 (512s)
  HostPoll Interval: 9 (512s)
  Restart parameter enabled, restarting Windows Time service
  Windows Time service restarted
  {
  }
Successful on 1 node: bolt-pdxwin27.classroom.puppet.com
Ran on 1 node in 4.97 sec
```

## Lab 9

Create and Run a Bolt Plan

```shell
$ mkdir -p Boltdir/modules/tools/plans
$ edit Boltdir/modules/tools/plans/timesync.pp
plan tools::timesync(
  TargetSpec $nodes,
) {
  run_task('tools::timesync', $nodes, restart => false)
  run_task('service::windows', $nodes, name => 'W32Time', action => 'restart')
}
$ bolt plan show
aggregate::count
aggregate::nodes
canary
facts
facts::info
puppetdb_fact
reboot
tools::timesync

MODULEPATH:
/home/jpryor/Documents/bolt-workshop/Boltdir/modules:/home/jpryor/Documents/bolt-workshop/Boltdir/site-modules:/home/jpryor/Documents/bolt-workshop/Boltdir/site

Use `bolt plan show <plan-name>` to view details and parameters for a specific plan.
02:48:47 jpryor@localhost ~/Documents/bolt-workshop $ bolt plan show tools::timesync

tools::timesync

USAGE:
bolt plan run tools::timesync nodes=<value>

PARAMETERS:
- nodes: TargetSpec

MODULE:
/home/jpryor/Documents/bolt-workshop/Boltdir/modules/tools
02:48:58 jpryor@localhost ~/Documents/bolt-workshop $ bolt plan run tools::timesync --nodes windows
Starting: plan tools::timesync
Starting: task tools::timesync on bolt-pdxwin27.classroom.puppet.com
Finished: task tools::timesync with 0 failures in 3.06 sec
Starting: task service::windows on bolt-pdxwin27.classroom.puppet.com
Finished: task service::windows with 0 failures in 2.93 sec
Finished: plan tools::timesync in 5.99 sec
Plan completed successfully with no result
```

## Lab 10

Install MV VS Code and Puppet extension

## Lab 11

Apply a Puppet Manifest
```shell
```

## Lab 12

```shell
```

## Lab 13

```shell
```
