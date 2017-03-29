/etc/salt/master.d:
  file.directory:
    - user: root
    - group: wheel
    - mode: 755
    - makedirs: True

salt-master:
  service.running:
    - enable: True
    - listen:
      - file: /etc/salt/master.d/peer.conf

/etc/salt/master.d/peer.conf:
  file.managed:
    - source: salt://gm/files/peer.conf

salt-minion:
  service.running:
    - enable: True
    - listen:
      - file: /etc/salt/minion.d/signing_policies.conf

/etc/salt/minion.d/signing_policies.conf:
  file.managed:
    - source: salt://gm/files/signing_policies.conf

/etc/ssl/certs:
  file.directory: []

/etc/ssl/issued_certs:
  file.directory: []

/etc/ssl/private/ca.key:
  x509.private_key_managed:
    - bits: 4096
    - backup: True

/etc/ssl/ca.crt:
  x509.certificate_managed:
    - signing_private_key: /etc/ssl/private/ca.key
    - CN: ca.c63-studio.com
    - C: FI
    - ST: Uusimaa
    - L: Helsinki
    - basicConstraints: "critical CA:true"
    - keyUsage: "critical cRLSign, keyCertSign"
    - subjectKeyIdentifier: hash
    - authorityKeyIdentifier: keyid,issuer:always
    - days_valid: 1825
    - days_remaining: 0
    - backup: True
    - require:
      - x509: /etc/ssl/private/ca.key

mine.send:
  module.run:
    - func: x509.get_pem_entries
    - kwargs:
        glob_path: /etc/ssl/ca.crt
    - onchanges:
      - x509: /etc/ssl/ca.crt

