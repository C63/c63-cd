{% set gpg_home = '/etc/salt/gpgkeys' %}
{% set gpg_public_key = '/etc/salt/gpgkeys/gpg_c63-salt-master.pub' %}

# this will also pull in gnupg
python-gnupg:
  pkg.installed

{% if not salt['file.directory_exists' ](gpg_home) %}
Generate gpg key:
  module.run:
    - name: gpg.create_key
    - key_type: RSA
    - key_length: 4096
    - name_real: c63-salt-master
    - expire_date: 2y
    - gnupghome: {{ gpg_home }}
    - timeout: 15
    - require:
      - pkg: python-gnupg

gpg --homedir {{ gpg_home }} --export --armor > {{ gpg_public_key }}:
  cmd.run:
    - creates:
      - {{ gpg_public_key }}
{% endif %}

