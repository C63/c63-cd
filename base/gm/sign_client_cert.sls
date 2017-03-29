{% set pki_dir = '/etc/ssl' %}

{% for csr in salt['cmd.run']('ls -1 %s/csr/*.csr'|format(pki_dir)).split('\n') %}
{% set fqdn = salt['cmd.run']("basename %s .csr"|format(csr)) %}
{% set path = "%s/certs/%s"|format(pki_dir, fqdn) %}

{% set signed = salt['cmd.retcode']("test ! -f %s.crt"|format(path)) %}

{% if not signed %}
{{ path }}.crt:
  x509.certificate_managed:
    - csr: {{ csr }}
    - signing_policy: default
    - backup: True
    - onlyif: test ! -f {{ path }}.crt
  event.wait:
    - name: salt/gm/signed_certificate_request
    - data:
        csr: {{ csr }}
        fqdn: {{ fqdn }}
        crt: {{ path }}.crt
    - watch:
      - x509: {{ path }}.crt
{% endif %}

{% endfor %}

