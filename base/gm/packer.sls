{% from 'lib/hashicorp_install.tmpl' import hashicorp_install %}
{{ hashicorp_install(
    'packer',
    '0.12.3',
    'https://releases.hashicorp.com/packer/0.12.3/packer_0.12.3_linux_amd64.zip',
    'd11c7ff78f546abaced4fcc7828f59ba1346e88276326d234b7afed32c9578fe'
) }}

