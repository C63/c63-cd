{% load_yaml as dirs%}
  /etc/openvpn/private: 700
  /etc/openvpn/private-client-conf: 700
  /etc/openvpn/certs: 755
  /var/openvpn/chrootjail/etc/ssl: 755
  /var/log/openvpn: 755
  /var/openvpn/chrootjail/var/openvpn: 755
  /var/openvpn/chrootjail/etc/openvpn: 755
  /var/openvpn/chrootjail/ccd: 755
  /var/openvpn/chrootjail/tmp: 755
{% endload %}

{% for path,mode in dirs.iteritems() %}
{{ path }}:
  file.directory:
    - user: root
    - group: wheel
    - mode: {{ mode }}
    - makedirs: True
{% endfor %}

/etc/ssl/ca.crl:
  file.symlink:
    - target: /var/openvpn/chrootjail/etc/ssl/ca.crl

/etc/openvpn/ccd:
  file.symlink:
    - target: /var/openvpn/chrootjail/ccd

/etc/openvpn/replay-persist-file:
  file.symlink:
    - target: /var/openvpn/chrootjail/etc/openvpn/replay-persist-file

