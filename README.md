<!-- DOCSIBLE START -->

# 📃 Role overview

## opkssh-role



Description: Ansible role to install and manage opkssh, a tool that enables SSH via OpenID Connect using identities like alice@example.com. This role is not affiliated with OpenPubkey or the opkssh project.











### Defaults

**These are static variables with lower priority**

#### File: defaults/main.yml

| Var          | Type         | Value       |Required    | Title       |
|--------------|--------------|-------------|------------|-------------|
| [opkssh_version](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L4)   | str | `latest` |    True  |  Version of opkssh to install |
| [opkssh_user](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L9)   | str | `opksshuser` |    True  |  Username uses for execution of opkssh |
| [opkssh_group](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L14)   | str | `opksshuser` |    True  |  Default group for opkssh user |
| [opkssh_selinux_home](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L18)   | bool | `True` |    True  |  Boolean to set whether to use the home directory policy feature |
| [opkssh_restart_ssh](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L22)   | bool | `True` |    True  |  Boolean to set if openSSH server should be restarted or not |
| [opkssh_install_path](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L26)   | str | `/usr/local/bin` |    True  |  Path to where opkssh binary should be installed |
| [opkssh_binary_name](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L30)   | str | `opkssh` |    True  |  Name of the opkssh binary |
| [opkssh_github_repo](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L34)   | str | `openpubkey/opkssh` |    True  |  GitHub repository to download the opkssh binary from |
| [opkssh_sudoers_path](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L38)   | str | `/etc/sudoers.d` |    True  |  Path to the sudoers file for opkssh |
| [opkssh_ssh_config_filename](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L42)   | str | `60-opk-ssh.conf` |    True  |  Name of the opkssh openSSH config file |
| [opkssh_config_yml](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L47)   | dict | `{}` |    True  |  Content of /etc/opk/config.yml |
| [opkssh_auth_id](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L52)   | list | `[]` |    True  |  Content of /etc/opk/auth_id file |
| [opkssh_providers](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L57)   | list | `[]` |    True  |  Content of /etc/opk/providers |
| [opkssh_providers.**0**](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L58)   | str | `https://accounts.google.com 206584157355-7cbe4s640tvm7naoludob4ut1emii7sf.apps.googleusercontent.com 24h` |    None  |  None |
| [opkssh_providers.**1**](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L59)   | str | `https://login.microsoftonline.com/9188040d-6c67-4c5b-b112-36a304b66dad/v2.0 096ce0a3-5e72-4da8-9c86-12924b294a01 24h` |    None  |  None |
| [opkssh_providers.**2**](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L60)   | str | `https://gitlab.com 8d8b7024572c7fd501f64374dec6bba37096783dfcd792b3988104be08cb6923 24h` |    None  |  None |
| [opkssh_providers.**3**](https://github.com/SweBarre/opkssh-role/blob/main/defaults/main.yml#L61)   | str | `https://issuer.hello.coop app_xejobTKEsDNSRd5vofKB2iay_2rN 24h` |    None  |  None |
<details>
<summary><b>🖇️ Full descriptions for vars in defaults/main.yml</b></summary>
<br>
<table>
<th>Var</th><th>Description</th>
<tr><td><b>opkssh_version</b></td><td>The version of opkssh to install, latest or vX.Y.Z</td></tr>
<tr><td><b>opkssh_user</b></td><td>The system user responsible for executing the AuthorizedKeysCommand</td></tr>
<tr><td><b>opkssh_group</b></td><td>Group ownership for installed files and directories</td></tr>
<tr><td><b>opkssh_config_yml</b></td><td>Content must be valid YAML format</td></tr>
<tr><td><b>opkssh_auth_id</b></td><td>Content must be a list, one entry per row</td></tr>
<tr><td><b>opkssh_providers</b></td><td>Content must be a list, one entry per row</td></tr>
</table>
<br>
</details>


### Vars

**These are variables with higher priority**
#### File: vars/main.yml

| Var          | Type         | Value       |
|--------------|--------------|-------------|
| [openssh_service_name](https://github.com/SweBarre/opkssh-role/blob/main/vars/main.yml#L1)   | str | `<multiline value: folded_strip>` |    
| [mod_tmp](https://github.com/SweBarre/opkssh-role/blob/main/vars/main.yml#L3)   | str | `{{ '/tmp/opkssh.mod' if opkssh_selinux_home else '/tmp/opkssh-no-home.mod' }}` |    
| [pp_tmp](https://github.com/SweBarre/opkssh-role/blob/main/vars/main.yml#L4)   | str | `{{ '/tmp/opkssh.pp' if opkssh_selinux_home else '/tmp/opkssh-no-home.pp' }}` |    
| [tefile](https://github.com/SweBarre/opkssh-role/blob/main/vars/main.yml#L5)   | str | `{{ 'opkssh.te' if opkssh_selinux_home else 'opkssh-no-home.te' }}` |    


### Tasks


#### File: tasks/absent.yml

| Name | Module | Has Conditions |
| ---- | ------ | -------------- |
| Remove the opkssh binary | ansible.builtin.file | False |
| Remove opkssh user | ansible.builtin.user | False |
| Remove opkssh group | ansible.builtin.group | False |
| Print out the SELinux status | ansible.builtin.debug | True |
| Set the correct name for opkssh SELinux module | ansible.builtin.set_fact | False |
| Check if SELinux module is installed and run handlers | ansible.builtin.command | True |
| Remove opkssh configuration directory | ansible.builtin.file | False |
| Remove opkssh SELinux source directory | ansible.builtin.file | False |
| Configure openSSH Server | ansible.builtin.file | False |
| Add sudoers file for opkssh | ansible.builtin.file | True |

#### File: tasks/client.yml

| Name | Module | Has Conditions |
| ---- | ------ | -------------- |
| Set binary name based on architecture | ansible.builtin.set_fact | False |
| Fail if unsupported architecture | ansible.builtin.fail | True |
| Set opkssh download base URL | ansible.builtin.set_fact | False |
| Download checksum list | ansible.builtin.uri | False |
| Find the checksums line for opkssh binary | ansible.builtin.set_fact | False |
| Extract SHA256 hash from the matched checksum line | ansible.builtin.set_fact | False |
| Download opkssh {{ opkssh_version }} | ansible.builtin.get_url | False |

#### File: tasks/main.yml

| Name | Module | Has Conditions |
| ---- | ------ | -------------- |
| Install opkssh binary | ansible.builtin.include_tasks | False |
| Create opkssh group | ansible.builtin.group | False |
| Create opkssh user | ansible.builtin.user | False |
| Print out the SELinux status | ansible.builtin.debug | True |
| Set the correct name for opkssh SELinux module | ansible.builtin.set_fact | False |
| Create opkssh SELinux source directory | ansible.builtin.file | True |
| Copy the SELinux module source file | ansible.builtin.copy | True |
| Create opkssh configuration directory | ansible.builtin.file | False |
| Create opkssh policy directory | ansible.builtin.file | False |
| Create opkssh providers file | ansible.builtin.template | False |
| Create opkssh config.yml file | ansible.builtin.template | False |
| Create the auth_id file for opkssh | ansible.builtin.template | False |
| Configure openSSH Server | ansible.builtin.template | False |
| Add sudoers file for opkssh | ansible.builtin.template | True |







## Author Information
Jonas Forsberg

#### License

MIT

#### Minimum Ansible Version

2.1

#### Platforms

- **Ubuntu**: [22.04, 24.04]
- **arch**: ['latest']
- **openSUSE**: [15.6, 'Tumbleweed']
- **RockyLinux**: [9]


#### Dependencies

No dependencies specified.
<!-- DOCSIBLE END -->

### Example Playbooks

#### Install opkssh with the opkssh role default role version (latest)
```yaml
- hosts: all
  roles:
    - role: opkssh
```


#### Install opksh specific version
```yaml
- hosts: all
  roles:
    - role: opkssh
      vars:
        opkssh_version: v0.6.1
```

#### Install opkssh latest version
```yaml
- hosts: all
  roles:
    - role: opkssh
      vars:
        opkssh_version: latest
```

#### Install opkssh and configure auth_id and providers
```yaml
- hosts: all
  roles:
    - role: opkssh
      vars:
        opkssh_auth_id:
          - alice alice@example.com https://accounts.google.com
          - guest alice@example.com https://accounts.google.com
          - root alice@example.com https://accounts.google.com
        opkss_providers:
          - "https://accounts.google.com 206584157355-7cbe4s640tvm7naoludob4ut1emii7sf.apps.googleusercontent.com 24h"
```

#### Install opkssh binary only (do not configure it as a server)
```yaml
- hosts: all
  tasks:
    - name: Install opkssh client binary only
      ansible.builtin.include_role:
        name: opkssh
        tasks_from: client
```

#### Uninstall opkssh binary and remove all server configuration
```yaml
- hosts: all
  tasks:
    - name: Uninstall opkssh
      ansible.builtin.include_role:
        name: opkssh
        tasks_from: absent
```