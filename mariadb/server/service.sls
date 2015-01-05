# Deal with MySQL service
mysql-server:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: mysql-server
    - require:
      - pkg: mysql-server
