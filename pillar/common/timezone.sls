{% load_yaml as timezone %}
  us-east-1: 'US/Eastern'
  us-east-2: 'US/Eastern'
  us-west-1: 'US/Pacific'
  us-west-2: 'US/Pacific'
  eu-west-1: 'Europe/Dublin'
  eu-west-2: 'Europe/London'
  eu-central-1: 'Europe/Berlin'
  sa-east-1: 'America/Sao_Paulo'
  ca-central-1: 'Canada/Central'
  ap-south-1: 'Asia/Kolkata'
  ap-northeast-1: 'Asia/Tokyo'
  ap-northeast-2: 'Asia/Seoul'
  ap-southeast-1: 'Asia/Singapore'
  ap-southeast-2: 'Australia/Sydney'
{% endload %}

timezone:
  name: {{ timezone['eu-central-1'] }}
  utc: True

