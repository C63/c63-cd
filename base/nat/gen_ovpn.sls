# This state will be called by cnc-gm whenever a
# 'salt/cnc-gm/signed_certificate_request' is fired
# flow:
# cnc-gm.sign_client_cert -> signal 'salt/cnc-gm/signed_certificate_request'
# -> cnc-gm.reactor -> cnc-gm.orchestrate -> cnc-vpn.gen_ovpn

{% set ovpn_dir = '/etc/openvpn/client' %}

{% set csr = salt.pillar.get('csr') %}
{% set fqdn = salt.pillar.get('fqdn') %}
{% set crt_content = salt.pillar.get('crt_content') %}

{{ ovpn_dir }}:
  file.directory:
    - user: root
    - dir_mode: 644
    - file_mode: 644

generate ovpn for {{ fqdn }}:
  module.run:
    - name: cp.get_template
    - path: salt://nat/files/client.ovpn
    - dest: {{ ovpn_dir }}/{{ fqdn }}.ovpn
    - kwargs:
        crt_content: |-
          {{ crt_content|indent(10) }}

