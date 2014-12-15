# Deal with MySQL service
mysql:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: mysql-server
    - require:
      - pkg: mysql-server
