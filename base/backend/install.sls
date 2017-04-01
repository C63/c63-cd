{% load_yaml as pkgs %}
  - openjdk-8-jdk
  - openjdk-8-jdk-headless
{% endload %}

{% for p in pkgs %}
{{ p }}:
  pkg.installed
{% endfor %}

lein:
  file.managed:
    - name: /usr/local/bin/lein
    - source: https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
    - source_hash: sha256=3f7c6474ff79ba90aa5fdf9f7d074d5d6b1f6cee6e10c917089f75a2fe24db37

runnable lein:
  file.managed:
    - name: /usr/local/bin/lein
    - mode: 755
    - watch:
      - file: lein
