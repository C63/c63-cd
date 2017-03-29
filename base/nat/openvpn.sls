include:
  - .dirs

openvpn:
  pkg.installed

/etc/openvpn/server.conf:
  file.managed:
    - source: salt://nat/files/openvpn.conf
    - user: root
    - group: wheel
    - mode: 644

/etc/rc.d/openvpn:
  file.managed:
    - source: salt://nat/files/openvpn.rc
    - user: root
    - group: wheel
    - mode: 755

/etc/rc.conf.local:
  file.managed:
    - source: salt://nat/files/rc.conf.local
    - user: root
    - group: wheel
    - mode: 644

/usr/local/sbin/openvpn --genkey --secret /etc/openvpn/private/vpn-ta.key:
  cmd.run:
    - creates: /etc/openvpn/private/vpn-ta.key

/usr/bin/openssl dhparam -out /etc/openvpn/dh.pem 2048:
  cmd.run:
    - creates: /etc/openvpn/dh.pem

/etc/ssl/private/vpn.c63-studio.com.key:
  x509.private_key_managed:
    - bits: 4096

/etc/ssl/certs/vpn.c63-studio.com.crt:
  x509.certificate_managed:
    - public_key: /etc/ssl/private/vpn.c63-studio.com.key
    - ca_server: gm
    - signing_policy: vpn-server
    - CN: dev-vpn.c63-studio.com
    - backup: True
    - require:
      - x509: /etc/ssl/private/vpn.c63-studio.com.key

