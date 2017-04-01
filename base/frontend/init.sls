{% from 'lib/gocd_install.tmpl' import gocd_install with context %}
{{ gocd_install('agent') }}

{% from 'lib/nginx.tmpl' import nginx with context %}
{{ nginx('modus.conf') }}

