{% if grains['os'] in ['Debian', 'Ubuntu'] %}

grafana-repo:
  pkgrepo.managed:
    - name: deb https://packagecloud.io/grafana/stable/debian/ jessie main
    - file: /etc/apt/sources.list.d/grafana.list
    - key_url: https://packagecloud.io/gpg.key

grafana:
  pkg.installed:
    - require:
      - pkgrepo: grafana-repo

grafana config:
  file.managed:
    - name: /etc/grafana/grafana.ini
    - user: grafana
    - mode: 400
    - source: salt://{{ slspath }}/files/grafana.ini
    - replace: True
    - create: True
    - require:
      - pkg: grafana

enable net bind:
  cmd.run:
    - name: setcap 'cap_net_bind_service=+ep' /usr/sbin/grafana-server

grafana-server:
  service.running:
    - enable: True
    - require:
      - file: grafana config
    - watch:
      - file: grafana config

{% endif %}
