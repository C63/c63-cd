{% set cidr_internal = '10.10.0.0/16'%}
{% set vpc_name = 'c63' %}
{% set vpc_id = 'vpc-91bc01f9' %}

vpc:
  id: {{ vpc_id }}
  name: {{ vpc_name }}
  region: eu-central-1
  cidr_internal: {{ cidr_internal }}
  cloud_key: c63-cloud-bootstrap
  cloud_key_location: /etc/salt/pki/c63-cloud-bootstrap.pem
  secgroup:
    - name: {{ vpc_name }}-nat-egress
      description: Outgoing traffic from vpc
      rule:
        - ip_protocol: tcp
          from_port: 80
          to_port: 80
          cidr_ip: {{ cidr_internal }}
        - ip_protocol: tcp
          from_port: 443
          to_port: 443
          cidr_ip: {{ cidr_internal }}
    - name: {{ vpc_name }}-default-internal
      description: default to allow http(s), ssh, icmp, salt from inside vpc
      rule:
        - ip_protocol: tcp
          from_port: 80
          to_port: 80
          cidr_ip: {{ cidr_internal }}
        - ip_protocol: tcp
          from_port: 443
          to_port: 443
          cidr_ip: {{ cidr_internal }}
        - ip_protocol: tcp
          from_port: 22
          to_port: 22
          cidr_ip: {{ cidr_internal }}
        - ip_protocol: tcp
          from_port: 4505
          to_port: 4506
          cidr_ip: {{ cidr_internal }}
        - ip_protocol: icmp
          from_port: -1
          to_port: -1
          cidr_ip: {{ cidr_internal }}
    - name: {{ vpc_name }}-vpn
      description: vpn connection
      rule:
        - ip_protocol: udp
          from_port: 1194
          to_port: 1194
          cidr_ip: '0.0.0.0/0'
    - name: {{ vpc_name }}-rds
      description: rds connection
      rule:
        - ip_protocol: tcp
          from_port: 5432
          to_port: 5432
          cidr_ip: {{ cidr_internal }}

