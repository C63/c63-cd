# TODO: fix telegraf for openbsd
{% if grains['os'] != 'OpenBSD' %}

{% set map = salt['grains.filter_by']({
  'Debian': {
    'repo': 'deb https://repos.influxdata.com/debian jessie stable'
  },
  'Ubuntu': {
    'repo': 'deb https://repos.influxdata.com/ubuntu xenial stable'
  }
}, grain='os') %}

{% set gpgkey = 'https://repos.influxdata.com/influxdb.key' %}

{% if grains['os'] in ['Debian', 'Ubuntu'] %}
telegraf-repo:
  pkgrepo.managed:
    - name: {{ map.repo }}
    - file: /etc/apt/sources.list.d/influxdb.list
    - key_url: {{ gpgkey }}
{% endif %}

Install telegraf:
  pkg.installed:
    - name: telegraf

telegraf config:
  file.managed:
    - name: /etc/telegraf/telegraf.conf
    - user: telegraf
    - mode: 700
    - source: salt://common/files/telegraf.conf
    - replace: True
    - template: jinja
    - create: True
    - require:
      - pkg: telegraf

telegraf:
  service.running:
    - enable: True
    - require:
      - file: telegraf config
    - watch:
      - file: telegraf config

{% endif %}

