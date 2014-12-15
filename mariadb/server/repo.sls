{% from "mariadb/map.jinja" import mariadb as mariadb_map with context %}

# We have a common template for the official MariaDB repo
{% include "mariadb/repo.sls" %}

# Here we just add a requisite declaration to ensure correct order
extend:
  mariadb_server_repo:
{%- if salt['grains.get']('os_family') == 'Debian' %}
    pkgrepo:
      - require_in:
        - pkg: mysql-server
{% else %} {}
{% endif %}
