{% set vpc_name = salt['pillar.get']('vpc:name') %}
{% set region = salt['pillar.get']('vpc:region') %}

{% for sg in salt['pillar.get']('vpc:secgroup') %}
Ensure {{ sg['name'] }} secgroup exists:
  boto_secgroup.present:
    - name: {{ sg['name'] }}
    - description:  {{ sg['description'] }}
    - vpc_name: {{ vpc_name }}
    - tags:
        Name: {{ sg['name'] }}
    - rules: {{ sg['rule'] }}
    - region: {{ region }}
{% endfor %}

