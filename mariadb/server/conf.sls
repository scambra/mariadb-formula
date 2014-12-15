# Config stuff for MySQL relateds
{% set os_family = salt['grains.get']('os_family', None) %}
{%- set server_config = salt['pillar.get']('mariadb:server:mysqld') %}

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
{% endif %}

{%- if server_config is defined and server_config is mapping %}
/etc/mysql/my.cnf:
  ini.options_present:
    - sections:
        mysqld:
{%- for key, value in server_config.items() %}
          {{ key }}: {{ value|json() }}
{%- endfor %}
    - watch_in:
      - service: mysql-server
    - require:
      - pkg: mysql-server
{%- endif %}
