Ensure PKG_PATH set correct to minion:
  environ.setenv:
    - name: PKG_PATH
    - value: 'http://ftp.hostserver.de/pub/OpenBSD/6.0/packages/amd64'
    - update_minion: True

