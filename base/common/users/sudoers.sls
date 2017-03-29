# add wheel group for Ubuntu and Debian
{% if grains['os'] in ['Debian', 'Ubuntu'] %}
wheel:
  group.present:
    - system: True

sudo:
  pkg.installed

/etc/sudoers.d/10-wheel-group:
  file.managed:
    - user: root
    - group: root
    - mode: 440
    - source: salt://common/files/10-wheel-group
    - require:
      - pkg: sudo
{% endif %}
