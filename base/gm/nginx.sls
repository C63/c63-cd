install nginx:
  pkg.installed:
    - name: nginx

/etc/nginx/sites/enabled/default:
  file.absent

/etc/nginx/sites-available/go-server-nginx.conf:
  file.managed:
    - source: salt://gm/files/go-server-nginx.conf

/etc/nginx/sites-enabled/go-server-nginx.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/go-server-nginx.conf

nginx:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx/sites-available/go-server-nginx.conf

