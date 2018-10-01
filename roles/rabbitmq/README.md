Ansible Role: stackstorm.rabbitmq
=================================

Installs RabbitMQ. If `rmq_users` is defined, then the guest user is removed, and the provided users are added.

Requirements
------------

No additional requirements.

Role Variables
--------------

These default variables can be set in the inventory's group or host vars, or pass them in as vars in the playbook that
uses this role. An example of passing in some of these vars is shown in an example playbook below.

* `rabbitmq_plugins`: A list of plugins to install (none by default: `[]`)
* `rabbitmq_vhosts`: A list of vhosts to add (make sure to include all vhosts included in `permissions` of `rabbitmq_users`. (default: `[]`)
* `rabbitmq_absent_vhosts`: A list of vhosts to remove. (default: `[]`)
* `rabbitmq_keep_guest_user`: Whether to keep or delete the guest user (default: `yes`)
* `rabbitmq_users`: A list of users to add (default: `[]`)
* `rabbitmq_absent_users`: A list of users to remove (default: `[]`)
* `rabbitmq_force_user_recreate`: Boolean to force user recreation. This is best set from extra-vars on the command line.

If you delete the guest (with `rabbitmq_keep_guest_user: no`), then make sure to specify at least one other user in `rabbitmq_users`. Note, you don't need to add the guest user to the `rabbitmq_absent_users` list, just set the `rabbitmq_keep_guest_user` bool to no.

Dependencies
------------

No role dependencies.

Example Playbook
----------------

This playbook installs rabbitmq without adding any users (leaving the default guest user):

    - hosts: localhost
      roles:
        - role: StackStorm.stackstorm/roles/rabbitmq


This playbook installs rabbitmq, removes the guest user, and adds a stackstorm user:

    - hosts: localhost
      roles:
        - role: StackStorm.stackstorm/roles/mongodb
          vars:
            rmq_users:
              - username: st2rmq
                password: stackstorm
                tags: policymaker
                permissions:
                  - vhost: 'st2'
                    configure_priv: .*
                    read_priv: .*
                    write_priv: .*

Note that tags can be zero, one, or more (comma separated) of these: management,policymaker,monitoring,administrator

WARNING: vhost should not have a leading / or you'd have to remember to encode it in the uri.

| vhost      | URI                                       |
|------------|-------------------------------------------|
| `/myvhost` | `amqp://user:pass@rabbit:5672/%2Fmyvhost` |
| `myvhost`  | `amqp://user:pass@rabbit:5672/myvhost`    |
| `/`        | `amqp://user:pass@rabbit:5672/`           |

License
-------

Apache 2.0

