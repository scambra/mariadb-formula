{% from "mariadb/map.jinja" import mariadb as mariadb_map with context %}

maria_dev:
  pkg.installed:
    - name: {{ pillar.get('mariadb', {}).get('dev-pkg', 'libmariadb-dev-compat') }}
