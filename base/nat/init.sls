include:
  - .pkg_path
  - .pf
  - .sysctl
  - .openvpn

{% from 'lib/salt.tmpl' import salt_pkgs, salt_files with context %}

{{ salt_pkgs(['salt']) }}
{{ salt_files(slspath, ['minion']) }}

