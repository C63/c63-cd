{% set tag = salt.pillar.get('tag') %}
{% set data = salt.pillar.get('data') %}

{% if tag == 'salt/gm/signed_certificate_request' %}
{% set crt_content = salt['cmd.run']('cat %s'|format(data['crt'])) %}
Running gen_ovpn.sls for nat:
  salt.state:
    - tgt: 'nat'
    - sls:
      - nat.gen_ovpn
    - pillar:
        csr: {{ data['csr'] }}
        fqdn: {{ data['fqdn'] }}
        crt_content: |-
          {{ crt_content|indent(10) }}
{% endif %}

{% if tag == 'salt/gm/crl_updated' %}
{% set crl_content = salt['cmd.run']('cat /etc/ssl/ca.crl') %}
Update crl to nat:
  salt.function:
    - name: file.write
    - tgt: '*'
    - arg:
      - /etc/ssl/ca.crl
      - {{ crl_content|yaml_encode }}
{% endif %}

