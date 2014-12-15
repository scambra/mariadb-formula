include:
  - mariadb.client.repo

# Install Mysql Client
mysql-client:
  pkg.installed:
    - name: mariadb-client
    - refresh: True
#    - require:
#      - pkgrepo: mariadb_client_repo
