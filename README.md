# Ansible-st2
Ansible playbooks to deploy [StackStorm](https://github.com/stackstorm/st2).
> [StackStorm](http://stackstorm.com/) is event-driven automation platform written in Python.
With over [50+ integrations](https://github.com/StackStorm/st2contrib/tree/master/packs) like GitHub, Docker, Nagios, NewRelic, AWS, Ansible it allows you to wire together your existing infrastructure into complex Workflows with auto-remediation and many more.
Aka IFTTT orchestration for Ops.

[![Circle CI Build Status](https://circleci.com/gh/StackStorm/ansible-st2/tree/master.svg?style=shield)](https://circleci.com/gh/StackStorm/ansible-st2/tree/master)

## Supported platforms
* Ubuntu 12.04
* Ubuntu 14.04

## Requirements
At least 2GB of memory and 3.5GB of disk space is required, since StackStorm is shipped with RabbitMQ, MySQL, Mongo, OpenStack Mistral and dozens of Python dependencies.

## Installation
```sh
ansible-galaxy install -r roles/st2/requirements.yml
ansible-playbook playbooks/st2express.yaml
```

## Variables
Below is the list of variables you can redefine in your playbook to customize st2 deployment:

| Variable            | Default       | Description  |
| ------------------- | ------------- | ----- |
| `st2_version`       | `stable`      | StackStorm version to install. Latest `stable`, `unstable` to get automatic updates or pin it to numeric version like `0.12.1`.
| `st2_revision`      | `current`     | StackStorm revision to install. `current` to get latest build (autoupdating) or pin it to numeric build like `6`.
| `st2_action_runners`| `ansible_processor_vcpus` | Number of action runner workers to start. Defaults to number of machine vCPUs, but not less than 2.
| `st2_system_user`   | `stanley`     | System user on whose behalf st2 would work, including remote/local action runners.
| `st2_auth_username` | `testu`       | Username used by StackStorm standalone authentication.
| `st2_auth_password` | `testp`       | Password used by StackStorm standalone authentication.

## Dependencies
Ansible Galaxy roles used by StackStorm installation:
 * [Stouts.mongodb](https://galaxy.ansible.com/list#/roles/982)

## Examples
Install `stable` StackStorm with all its components on local machine:
```sh
ansible-playbook playbooks/st2express.yaml -i 'localhost,' --connection=local
```

> Note that keeping `stable` version is useful to update StackStorm by re-running playbook, since it will reinstall st2 if there is new version available.
This is default behavior. If you don't want updates - consider pinning version numbers. 

Install specific numeric version of st2 with pinned revision number as well:
```sh
ansible-playbook playbooks/st2express.yaml --extra-vars='st2_version=0.12.2 st2_revision=6'
```
or latest unstable (development branch):
```sh
ansible-playbook playbooks/st2express.yaml --extra-vars='st2_version=unstable'
```

## Other Installers
For your best experience there are different convenient ways to install and explore StackStorm engine.
* [All-in-one Installer](http://docs.stackstorm.com/install/all_in_one.html) - preferred way (especially for production). Graphical installer, more secure, better tested and robust.
* [Chef](https://supermarket.chef.io/cookbooks/stackstorm)
* [Puppet](https://forge.puppetlabs.com/stackstorm/st2)
* [Bash](http://docs.stackstorm.com/install/index.html#installation)
* [Docker](https://hub.docker.com/r/stackstorm/)
* [Vagrant](https://github.com/StackStorm/st2workroom/)

## Help
If you're in stuck, our community always ready to help, feel free to:
* Ask questions on [IRC: #stackStorm on freenode.net](http://webchat.freenode.net/?channels=stackstorm) or our [public Slack channel](https://stackstorm.typeform.com/to/K76GRP)
* Report bug, provide feature request or just give us a ✮ star at [GitHub st2](https://github.com/StackStorm/st2)
