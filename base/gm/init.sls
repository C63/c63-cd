include:
  - .gpg
  - .boto
  - .ca
  - .gocd
  - .nginx
  - .packer
  - .secgroup
  - .cloud

{% from 'lib/salt.tmpl' import salt_files, salt_pkgs with context %}
{{ salt_pkgs(['salt-minion', 'salt-master', 'salt-cloud', 'salt-ssh']) }}
{{ salt_files(slspath, ['master', 'minion']) }}

git:
  pkg.installed
