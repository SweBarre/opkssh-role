<!-- DOCSIBLE START -->

# 📃 Role overview

## opkssh



Description: Ansible role to install and manage opkssh, a tool that enables SSH via OpenID Connect using identities like alice@example.com. This role is not affiliated with OpenPubkey or the opkssh project.











### Defaults

**These are static variables with lower priority**

#### File: defaults/main.yml

| Var          | Type         | Value       |Required    | Title       |
|--------------|--------------|-------------|------------|-------------|
| [opkssh_version](defaults/main.yml#L4)   | str | `v0.7.0` |    True  |  Version of opkssh to install |
| [opkssh_bin_checksum](defaults/main.yml#L9)   | str | `sha256:047ce46214e94c25820a3345927886c048a93254af329e50fa5e76cc43269556` |    True  |  Checksum of opkssh to install |
| [opkssh_user](defaults/main.yml#L14)   | str | `opksshuser` |    True  |  Username uses for execution of opkssh |
| [opkssh_group](defaults/main.yml#L19)   | str | `opksshuser` |    True  |  Default group for opkssh user |
| [opkssh_selinux_home](defaults/main.yml#L23)   | bool | `True` |    True  |  Boolean to set wether to use the home directory policy feature |
| [opkssh_restart_ssh](defaults/main.yml#L27)   | bool | `True` |    True  |  Boolean to set if openSSH server should be restarted or not |
| [opkssh_install_path](defaults/main.yml#L31)   | str | `/usr/local/bin` |    True  |  Path to where opkssh binary should be installed |
| [opkssh_binary_name](defaults/main.yml#L35)   | str | `opkssh` |    True  |  Name of the opkssh binary |
| [opkssh_github_repo](defaults/main.yml#L39)   | str | `openpubkey/opkssh` |    True  |  GitHub repository to download the opkssh binary from |
| [opkssh_sudoers_path](defaults/main.yml#L43)   | str | `/etc/sudoers.d` |    True  |  Path to the sudoers file for opkssh |
| [opkssh_ssh_config_filename](defaults/main.yml#L47)   | str | `60-opk-ssh.conf` |    True  |  Name of the opkssh openSSH config file |
| [opkssh_config_yml](defaults/main.yml#L52)   | dict | `{}` |    True  |  Content of /etc/opk/config.yml |
| [opkssh_auth_id](defaults/main.yml#L57)   | list | `[]` |    True  |  Content of /etc/opk/auth_id file |
| [opkssh_providers](defaults/main.yml#L62)   | list | `[]` |    True  |  Content of /etc/opk/providers |
| [opkssh_providers.**0**](defaults/main.yml#L63)   | str | `https://accounts.google.com 206584157355-7cbe4s640tvm7naoludob4ut1emii7sf.apps.googleusercontent.com 24h` |    None  |  None |
| [opkssh_providers.**1**](defaults/main.yml#L64)   | str | `https://login.microsoftonline.com/9188040d-6c67-4c5b-b112-36a304b66dad/v2.0 096ce0a3-5e72-4da8-9c86-12924b294a01 24h` |    None  |  None |
| [opkssh_providers.**2**](defaults/main.yml#L65)   | str | `https://gitlab.com 8d8b7024572c7fd501f64374dec6bba37096783dfcd792b3988104be08cb6923 24h` |    None  |  None |
| [opkssh_providers.**3**](defaults/main.yml#L66)   | str | `https://issuer.hello.coop app_xejobTKEsDNSRd5vofKB2iay_2rN 24h` |    None  |  None |
<details>
<summary><b>🖇️ Full descriptions for vars in defaults/main.yml</b></summary>
<br>
<table>
<th>Var</th><th>Description</th>
<tr><td><b>opkssh_version</b></td><td>The version of opkssh to install, if 'latest' is used the role can break idempotency</td></tr>
<tr><td><b>opkssh_bin_checksum</b></td><td>The sha256 checksum of the opkssh binary, not used if opkss_version is set to 'latest'</td></tr>
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
| [openssh_service_name](vars/main.yml#L1)   | str | `<multiline value: folded_strip>` |    
| [te_tmp](vars/main.yml#L3)   | str | `{{ '/tmp/opkssh.te' if opkssh_selinux_home else '/tmp/opkssh-no-home.te' }}` |    
| [mod_tmp](vars/main.yml#L4)   | str | `{{ '/tmp/opkssh.mod' if opkssh_selinux_home else '/tmp/opkssh-no-home.mod' }}` |    
| [pp_tmp](vars/main.yml#L5)   | str | `{{ '/tmp/opkssh.pp' if opkssh_selinux_home else '/tmp/opkssh-no-home.pp' }}` |    
| [tefile](vars/main.yml#L6)   | str | `{{ 'opkssh.te' if opkssh_selinux_home else 'opkssh-no-home.te' }}` |    


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
| Create opkssh configuration directory | ansible.builtin.file | False |
| Configure openSSH Server | ansible.builtin.file | False |
| Add sudoers file for opkssh | ansible.builtin.file | True |

#### File: tasks/client.yml

| Name | Module | Has Conditions |
| ---- | ------ | -------------- |
| Set binary name based on architecture | ansible.builtin.set_fact | False |
| Fail if unsupported architecture | ansible.builtin.fail | True |
| Download opkssh (latest) | ansible.builtin.get_url | True |
| Download opkssh specific version: {{ opkssh_version }} | ansible.builtin.get_url | True |

#### File: tasks/main.yml

| Name | Module | Has Conditions |
| ---- | ------ | -------------- |
| Install opkssh binary | ansible.builtin.include_tasks | False |
| Create opkssh group | ansible.builtin.group | False |
| Create opkssh user | ansible.builtin.user | False |
| Print out the SELinux status | ansible.builtin.debug | True |
| Set the correct name for opkssh SELinux module | ansible.builtin.set_fact | False |
| Check if SELinux module is installed and run handlers | ansible.builtin.command | True |
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

#### Install opkssh with the opkssh role default version
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
        opkssh_bin_checksum: "sha256:61646ef0f977aaa374a31e3135d322b8b29c86d51695eb02642e9e0166ef15dd"
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