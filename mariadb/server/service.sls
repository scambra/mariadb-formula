# Deal with MySQL service
extend:
  mysql-server:
    service.running:
      - name: mysql
      - enable: True
      - reload: True
      - watch:
        - pkg: mysql-server
      - require:
        - pkg: mysql-server
