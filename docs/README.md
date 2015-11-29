# Documentation

## Example

```
mysql_version: 10.1
mysql_root_password: root-password
mysql_global_config:
  - { section: client, option: port, value: 3306 }
  - { section: mysqld, option: max_connections, value: 150 }
  - { section: mysqld, option: key_buffer_size, value: 256M }
  - { section: mysqld, option: max_allowed_packet, value: 64M }
mysql_users:
  - name: my-domain
    host: "%"
    password: database-password
    priv: "my-database.*:ALL"
  - name: old-client
    state: absent
mysql_databases:
  - name: my-database
    encoding: utf8
    collation: utf8_general_ci
  - name: old-database
    state: absent
```

## Role Variables

Available variables are listed below, along with default values (see [defaults/main.yml](/defaults/main.yml)):

```
mysql_ppa:
```

The launchpad PPA to add to APT. Which would allow a non-official package of MySQL to be installed.

```
mysql_version: 10.1
```

The MySQL package version you want to install.

```
mysql_repo_state: present
```

The desired MySQL repository state, valid values are `present`, or `absent`.

```
mysql_repo_uid: mariadb
```

The unique repository identifier for RedHat/CentOS .

```
mysql_repo_name: MariaDB
```

The human readable repository name for RedHat/CentOS.

```
mysql_repo_baseurl: http://yum.mariadb.org/{{ mysql_version }}/centos/{{ ansible_distribution_major_version }}/$basearch/
```

The repository URL for RedHat/CentOS.

```
mysql_repo_gpgkey: https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
```

The GPG key URL for RedHat/CentOS.

```
mysql_repo_gpgcheck: 1
```

Whether GPG signature checking is enabled or disabled for RedHat/CentOS.

```
mysql_repo_enabled: 1
```

Whether the repository is enabled or disabled globally for RedHat/CentOS.

```
mysql_repo_url: deb http://mariadb.uberglobalmirror.com/repo/{{ mysql_version }}/ubuntu {{ ansible_distribution_release | lower }} main
```

The repository URL for Debian/Ubuntu.

```
mysql_repo_key_id: 1BB943DB
```

The repository key identifier for Debian/Ubuntu.

```
mysql_repo_key_server: keyserver.ubuntu.com
```

The keyserver to provide the GPG key for Debian/Ubuntu.

```
mysql_service_name:
```

The name of the daemon under which MySQL runs. Typically this can be omitted since it's automatically determined
based on the target operating system. For RedHat/CentOS this is `mysqld` and Debian/Ubuntu it's `mysql`.

```
mysql_service_state: started
```

The desired MySQL service state, valid values are `started`, `stopped`, `restarted` or `reloaded`.

```
mysql_service_enabled: yes
```

Whether the MySQL service should start on boot, valid values are `yes`, or `no`.

```
mysql_packages:
```

A list of the MySQL packages to install. Each package supports all parameters from the
[apt](http://docs.ansible.com/ansible/apt_module.html) or [yum](http://docs.ansible.com/ansible/yum_module.html) modules.
If the value remains omitted, the following packages will be installed by default.

| Debian/Ubuntu          | RedHat/CentOS           |
| :--------------------- | :---------------------- |
| mariadb-client         |  MariaDB-client         |
| mariadb-server         |  MariaDB-server         |

```
mysql_pid_path: /var/run/mysqld
```

The location for storing MySQL pid files.

```
mysql_log_path: /var/log/mysql
```

The location for storing MySQL log files.

```
mysql_global_config_file:
```

The file name of the MySQL configuration file. Typically this can be omitted since it's automatically determined
based on the target operating system. For RedHat/CentOS this is `/etc/my.cnf` and Debian/Ubuntu it's `/etc/mysql/my.cnf`.

```
mysql_global_config_file_refresh: no
```

Whether to refresh the MySQL configuration file by overriding it with the contents with `mysql_global_config_template`.

```
mysql_global_config_template: my.cnf.j2
```

The name of the MySQL configuration template. Typically you won't need to override this value since it's only used
as an initial replacement, for normalising settings across different operating systems.

```
mysql_global_config:
```

An array of option hashes used to customise the global MySQL configuration settings. Each option expects three
parameters, `section` which is the section name in CNF file, `option` if set (required for changing a value), is
the name of the option and can be omitted if adding/removing a whole section. Then finally `value`, a string
value to be associated with an option, this can also be omitted when removing an option.

```
mysql_root_config_file: /root/.my.cnf
```

The file name of the root user MySQL configuration file.

```
mysql_root_config_template: root.my.cnf.j2
```

The name of the root user MySQL configuration template.

```
mysql_root_username: root
```

The MySQL root user account username.

```
mysql_root_password: ''
```

The MySQL root user account password.

```
mysql_update_root_password: no
```

Whether the MySQL root user's password should be updated. This role by default, will only change the root user's
password when MySQL is first configured. You can force an update by setting this to `yes`.

```
mysql_resize_innodb_log_files: no
```

Whether the InnoDB log files should be resized, which requires the MySQL server to be shut down and restarted after
changing the MySQL configuration setting `innodb_log_file_size`.

```
mysql_users:
```

A list of the MySQL users to manage. Each user supports all parameters from the
[mysql_user](http://docs.ansible.com/ansible/mysql_user_module.html) module.

```
mysql_databases:
```

A list of the MySQL databases to manage. Each database supports all parameters from the
[mysql_db](http://docs.ansible.com/ansible/mysql_db_module.html) module.