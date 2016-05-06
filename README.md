# Ansible-st2
Ansible playbooks to deploy [StackStorm](https://github.com/stackstorm/st2).
> [StackStorm](http://stackstorm.com/) is event-driven automation platform written in Python.
With over [50+ integrations](https://github.com/StackStorm/st2contrib/tree/master/packs) like GitHub, Docker, Nagios, NewRelic, AWS, Ansible it allows you to wire together your existing infrastructure into complex Workflows with auto-remediation and many more.
Aka IFTTT orchestration for Ops.

[![Circle CI Build Status](https://circleci.com/gh/StackStorm/ansible-st2/tree/master.svg?style=shield)](https://circleci.com/gh/StackStorm/ansible-st2/tree/master)
[![Repository deb/rpm](https://img.shields.io/badge/Repository-deb/rpm-blue.svg)](https://packagecloud.io/StackStorm/stable/)

## Supported platforms
* Ubuntu 14.04

## Requirements
At least 2GB of memory and 3.5GB of disk space is required, since StackStorm is shipped with RabbitMQ, PostgreSQL, Mongo, OpenStack Mistral and dozens of Python dependencies.

## Installation
```sh
ansible-galaxy install -r roles/mistral/requirements.yml

ansible-playbook playbooks/st2express.yaml
```

## Dependencies
Ansible Galaxy roles used by StackStorm installation:
 * [ANXS.postgresql](https://galaxy.ansible.com/list#/roles/512) - PostgreSQL, needed by Mistral

## Variables
Below is the list of variables you can redefine in your playbook to customize st2 deployment:

| Variable              | Default       | Description  |
| --------------------- | ------------- | ----- |
| `st2_version`         | `stable`      | StackStorm version to install. Use latest `stable` to get automatic updates or pin it to numeric version like `1.4.0`.
| `st2_revision`        | `1`           | StackStorm revision to install. Used only with pinned `st2_version`.
| `st2_system_user`     | `stanley`     | System user on whose behalf st2 would work, including remote/local action runners.
| `st2_system_user_in_sudoers` | `yes`| Add `st2_system_user` to the sudoers (recommended for most `st2` features to work).
| `st2_auth_username`   | `testu`       | Username used by StackStorm standalone authentication.
| `st2_auth_password`   | `testp`       | Password used by StackStorm standalone authentication.
| `mistral_db`          | `mistral`     | PostgreSQL DB name for Mistral.
| `mistral_db_username` | `mistral`     | PostgreSQL DB user for Mistral.
| `mistral_db_password` | `StackStorm`  | PostgreSQL DB password for Mistral.

## Examples
Install latest `stable` StackStorm with all its components on local machine:
```sh
ansible-playbook playbooks/st2express.yaml -i 'localhost,' --connection=local
```

> Note that keeping `stable` version is useful to update StackStorm by re-running playbook, since it will reinstall st2 if there is new version available.
This is default behavior. If you don't want updates - consider pinning version-revision numbers. 

Install specific numeric version of st2 with pinned revision number as well:
```sh
ansible-playbook playbooks/st2express.yaml --extra-vars='st2_version=1.4.0 st2_revision=8'
```

## Other Installers
You might be interested in other OS flavors to explore StackStorm engine:
* [Ubuntu/Debian](https://docs.stackstorm.com/install/deb.html)
* [RHEL7/CentOS7](https://docs.stackstorm.com/install/rhel7.html)
* [RHEL6/CentOS7](https://docs.stackstorm.com/install/rhel6.html)

## Help
If you're in stuck, our community always ready to help, feel free to:
* Ask questions in our [public Slack channel](https://stackstorm.com/community-signup)
* [Report bug](https://github.com/StackStorm/ansible-st2/issues), provide [feature request](https://github.com/StackStorm/ansible-st2/pulls) or just give us a ✮ star

Your contribution is more than welcome!
