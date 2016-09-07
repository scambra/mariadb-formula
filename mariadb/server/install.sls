include:
  - mariadb.server.repo

{%- set os_family = salt['grains.get']('os_family', None) %}
{%- set mysql_root_password = salt['pillar.get']('mariadb:server:root_password', salt['grains.get']('server_id')) %}

{%- if mysql_root_password and os_family == 'Debian' %}
mysql_debconf:
  debconf.set:
    - name: mysql-server
    - data:
        'mysql-server/root_password': {'type': 'password', 'value': '{{ mysql_root_password }}'}
        'mysql-server/root_password_again': {'type': 'password', 'value': '{{ mysql_root_password }}'}
        'mysql-server/start_on_boot': {'type': 'boolean', 'value': 'true'}
    - require_in:
      - pkg: mysql-server
{%- endif %}

# This installs MariaDB
mysql-server:
  pkg.installed:
    - name: mariadb-server
    - refresh: True
{%- if os_family == 'Debian' %}
    - require:
      - debconf: mysql_debconf
{%- endif %}
#      - pkgrepo: mariadb_server_repo
