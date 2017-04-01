{% set ami_id = 'ami-3f1bd150' %}

vpc:
  instances:
    - name: c63-frontend
      image_id: {{ ami_id }}
      private_ip_address: 10.10.1.10
      size: t2.micro
      subnet: subnet-78dfa210
      secgroup:
        - c63-nat-egress
        - c63-default-internal
        - c63-rds
    - name: c63-backend
      image_id: {{ ami_id }}
      private_ip_address: 10.10.1.20
      size: t2.micro
      subnet: subnet-78dfa210
      secgroup:
        - c63-nat-egress
        - c63-default-internal
        - c63-rds
