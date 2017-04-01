{% set vpc_name = salt['pillar.get']('vpc:name') %}
{% set region = salt['pillar.get']('vpc:region') %}

/etc/salt/cloud.providers.d/ec2.provider.conf:
  file.managed:
    - source: salt://gm/files/cloud/ec2.provider.conf
    - template: jinja
    - replace: True
    - makedirs: True
    - user: mdk
    - create: True

/etc/salt/cloud.profiles.d/ec2.profile.conf:
  file.managed:
    - source: salt://gm/files/cloud/ec2.profile.conf
    - template: jinja
    - replace: True
    - makedirs: True
    - create: True
    - user: mdk
    - require:
      - file: /etc/salt/cloud.providers.d/ec2.provider.conf

/etc/salt/cloud.map.d/map.conf:
  file.managed:
    - source: salt://gm/files/cloud/map.conf
    - template: jinja
    - replace: True
    - makedirs: True
    - create: True
    - user: mdk

