# Integration for MariaDB into Salt-minion
{% set os_family = salt['grains.get']('os_family', None) %}

# Teach Salt to use the debian.cnf file
{%- if os_family == 'Debian' %}
salt_mysql_config:
  file.managed:
    - name: /etc/salt/minion.d/mysql.conf
    - contents: "mysql.default_file: '/etc/mysql/debian.cnf'"
    - require:
      - pkg: salt-minion
      - pkg: mysql-server
    - watch_in:
      - service: salt-minion
    - require_in:
      - service: salt-minion
{% endif %}

# We need python-mysqldb in order to make users and such
python-mysqldb:
  pkg.installed:
    - watch_in:
      - service: salt-minion
