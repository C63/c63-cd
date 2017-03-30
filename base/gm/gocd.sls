{% load_yaml as java_pkgs %}
  - openjdk-8-jdk-headless
  - openjdk-8-jdk
  - openjdk-8-jre-headless
  - openjdk-8-jre
{% endload %}

{% if grains['os'] == 'Debian' %}

jessie-backports:
  pkgrepo.managed:
    - name: deb http://ftp.debian.org/debian jessie-backports main
    - file: /etc/apt/sources.list.d/jessie-backports.list

{% for p in java_pkgs %}
{{ p }}:
  pkg.installed:
    - fromrepo: jessie-backports
{% endfor %}

gocd:
  pkgrepo.managed:
    - name: deb https://download.gocd.io /
    - file: /etc/apt/sources.list.d/gocd.list
    - key_url: https://download.gocd.io/GOCD-GPG-KEY.asc

{% for pkg in ['server', 'agent'] %}
go-{{ pkg }}:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: go-{{ pkg }}
{% endfor %}

{% endif %}
