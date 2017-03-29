Ensure pf has correct rules:
  file.managed:
    - name: /etc/pf.conf
    - user: root
    - mode: 400
    - source: salt://nat/files/pf.conf
    - replace: True
    - create: True
  cmd.run:
    - names:
      - pfctl -e || true
      {# NOTE: extra space for -f option to force pfctl -e command run first #}
      - pfctl  -f /etc/pf.conf
    - onchanges:
      - file: /etc/pf.conf
