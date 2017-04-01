/etc/systemd/system/modus.service:
  file.managed:
    - source: salt://backend/files/modus.service
    - template: jinja

run modus at boot:
  cmd.run:
    - name: systemctl enable modus.service
    - watch:
      - file: /etc/systemd/system/modus.service

restart modus:
  cmd.run:
    - name: systemctl restart modus
    - watch:
      - file: /etc/systemd/system/modus.service
