include:
  - .sudoers

{% from 'common/users/sshd_config.tmpl' import sshd_config with context %}
{% from 'common/users/user_linux.tmpl' import user_linux with context %}
{% from 'common/users/user_openbsd.tmpl' import user_openbsd with context %}

# Set users & sshd_config
{% set allowed_users = salt['pillar.get']('admin').keys() %}
{{ sshd_config(allowed_users) }}

# add admins and ssh public key
# all admins will have same password from sudo pillar
{% set password = salt['pillar.get']('sudo:password') %}
{% for user,data in salt['pillar.get']('admin').iteritems() %}
  {% if grains['os'] in ['Ubuntu', 'Debian'] -%}
    {{ user_linux(user, password) }}
  {%- endif %}

  {% if grains['os'] == 'OpenBSD' -%}
    {{ user_openbsd(user, password) }}
  {%- endif %}

  {% set ssh_pub_key = data['ssh_pub_key'] %}
  {%- include 'common/users/ssh_pubkey.tmpl' with context -%}
{% endfor %}


# revoked user, f.ex: ec2-user
{% for revoked_user in salt['pillar.get']('revoked_users') %}
{{ revoked_user }}:
  user.absent
{% endfor %}
