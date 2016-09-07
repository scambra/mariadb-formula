{%- set init_system = salt['grains.get']('init', 'upstart') %}
# Deal with MySQL service
extend:
  mysql-server:
    service.running:
      - name: mysql
      - enable: True
      - reload: {% if init_system != 'systemd' -%} True {% else %} False {% endif %}
      - watch:
        - pkg: mysql-server
      - require:
        - pkg: mysql-server
