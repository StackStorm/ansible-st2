ansible-pip
===========

An ansible role that ensures pip is installed at the version you specify.
It uses `get-pip.py` to install pip.

See role in [ansible-galaxy](https://galaxy.ansible.com/bobbyrenwick/pip/) and on [github](https://github.com/bobbyrenwick/ansible-pip)

_Note: A copy of this role (licensed under Apache 2.0) is included in the StackStorm/ansible-st2 repo to make CI/maintenance simpler.
@cognifloyd will manage pushing any changes from here upstream._

Role Variables
--------------

- `pip_download_dest` specifies where `get-pip.py` should be downloaded to. Defaults to `/tmp`
- `pip_version` specifies which version of pip you want to install.
  - Defaults to `None`, to install the latest version (If pip is installed, upgrades to the latest pip version available)
  - Can be set to a specific version, e.g. `"6.0.8"` to force installation of that version.
  - Can be set explicitly to `"LATEST"` or `"latest"` to force upgrade to the latest available version (same behaviour as `None`).
- `python` specifies what Python executable to use.  Defaults to `python`.
- `pip` specifies what pip executable to check and use.  Defaults to `pip`.
- `pip_proxy` specifies a HTTP proxy, if you have to use it (e.g. behind firewall). Default is `` to skip it.

Contributors
------------
Thanks to everyone who has contributed! (github account listed in parentheses).

- Bob Renwick (@bobbyrenwick)
- George Macon (@gmacon)
- Michal Gasek (@michalgasek)
- Joe Schaul (@jschaul)
- Conor Schaefer (@conorsch)
- Anton Belonovich (@binary-data)
- Anton Bormotov (@antonbormotov)
- Alexander Meindl (@alexandermeindl)
- Gilad Peleg (@pgilad)
- Jacob Floyd (@cognifloyd)
