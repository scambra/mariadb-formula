{%- set lsb_codename = salt['grains.get']('lsb_distrib_codename') %}
{%- set stable_version = '10.1' %}
{%- set repo_version = salt['pillar.get']('mariadb:repo_version', stable_version) %}
{%- set version = salt['pillar.get']('mariadb:version', 'latest') %}
{%- set repourl = salt['pillar.get']('mariadb:repourl', 'http://ftp.nluug.nl/db/mariadb') %}

{% if sls == "mariadb.client.repo" %}{% set id_prefix = "mariadb_client" -%}
{% elif sls == "mariadb.server.repo" %}{% set id_prefix = "mariadb_server" -%}
{% else %}{% set id_prefix = "mariadb" -%}
{% endif -%}

# Starting with Ubuntu 15.10 the signing key has changed
{%- set repo_key = salt['pillar.get']('mariadb:repokey', "0xcbcb082a1bb943db") %}
{%- if salt['grains.get']('osfullname') == 'Ubuntu' and salt['grains.get']('osrelease')|float() >= 15.10 %}
{%- set repo_key = "0xF1656F24C74CD1D8" %}
{%- endif %}

# Deal with difference between stable/repo version and explicit versions
{%- set repo_url_version = stable_version %}
{%- if version is defined %}
{%- set repo_url_version = 'mariadb-' ~ version %}
{%- elif repo_version is defined %}
{%- set repo_url_version = repo_version %}
{%- endif %}

# Install MariaDB repository
{{ id_prefix }}_repo:
  pkgrepo.managed:
    - humanname: MariaDB PPA
    - name: deb {{ repourl }}/repo/{{ repo_url_version }}/ubuntu {{ lsb_codename }} main
    - dist: {{ lsb_codename }}
    - file: /etc/apt/sources.list.d/mariadb.list
    - keyid: "{{ repo_key }}"
    - keyserver: keyserver.ubuntu.com
    - refresh: True
    - clean_file: True
