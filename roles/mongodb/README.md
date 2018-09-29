Ansible Role: stackstorm.mongodb
================================

Installs MongoDB. If the `mongodb_auth_enable` boolean is enabled, then this also enables authentication, adds an admin
user, and adds any other users defined in `mongodb_users`.

Requirements
------------

Enabling mongo auth requires the pymongo python module (requirement of the mongo_users ansible module).

Role Variables
--------------

These default variables can be set in the inventory's group or host vars, or pass them in as vars in the playbook that
uses this role. An example of passing in some of these vars is shown in an example playbook below.

* `mongodb_version`: The major.minor version to install (only 3.4 or 3.2 are supported).
* `mongodb_enable_auth`: Whether or not to enable auth in mongodb (default: no)
* `mongodb_host`: Login to this host to add users (default '127.0.0.1')
* `mongodb_port`: Login on this port to add users (default '27017')
* `mongodb_admin_username`: The admin's username (default 'admin')
* `mongodb_admin_password`: The admin's password (default: generate a random password and store it in a file)
* `mongodb_users`: A list of users to add (see example playbook below; default: [])
* `mongodb_creds_dir`: The directory that should hold any generated credentials like admin (default: '.')

Dependencies
------------

On RedHat family distributions, this depends on the stackstorm.epel role.

Example Playbook
----------------

This playbook installs mongo without enabling auth or adding any users:

    - hosts: localhost
      roles:
        - role: StackStorm.stackstorm/roles/mongodb


This playbook installs mongo, enables auth, and adds a stackstorm user, and force update the password if it already exists:

    - hosts: localhost
      roles:
        - role: StackStorm.stackstorm/roles/mongodb
          vars:
            mongodb_enable_auth: yes
            mongodb_users:
              - db: st2
                username: st2mongo
                password: "{{ lookup('password', '{{ mongodb_creds_dir }}/mongodb-' + inventory_hostname + '-' + st2mongo_username + ' length=42' ) }}"
                roles: readWrite
            mongodb_force_password_update: yes

Note that the `readWrite` mongo role is used by default, so `roles` can be ommitted for the above playbook.
You can use the roles attribute to add any other mongo roles to your user.

License
-------

Apache 2.0

