{% set vpc_id = salt['pillar.get']('vpc:id') %}
{% set region = salt['pillar.get']('vpc:region') %}

{% for sg in salt['pillar.get']('vpc:secgroup') %}
Ensure {{ sg['name'] }} secgroup exists:
  boto_secgroup.present:
    - name: {{ sg['name'] }}
    - description:  {{ sg['description'] }}
    - vpc_id: {{ vpc_id }}
    - tags:
        Name: {{ sg['name'] }}
    - rules: {{ sg['rule'] }}
    - region: {{ region }}
{% endfor %}

