{%- set init_system = salt['grains.get']('init', 'upstart') %}
# Deal with MySQL service
extend:
  mysql-server:
    service.running:
      - name: mysql
      - enable: True
      - watch:
        - pkg: mysql-server
      - require:
        - pkg: mysql-server

# There is no reload target when using systemd
{% if init_system != 'systemd' -%}
extend:
  mysql-server:
    service.running:
      - reload: True
{% endif %}
