{% if opts['id'] != 'gm' %}
Manage ca certificate:
  file.managed:
    - name: /etc/ssl/ca.crt
    - user: root
    - mode: 400
    - contents: {{ salt['mine.get']('gm', 'x509.get_pem_entries')['gm']['/etc/ssl/ca.crt']|yaml_encode }}
{% endif %}

