rtorrent_deps:
  pkg.installed:
    - names:
      - rtorrent
      - screen
      - ffmpeg
      - unzip
      - unrar
      - mediainfo
      - curl

start_rtorrent:
  cmd.run:
    - name: screen -d -m -S rtorrent rtorrent
    - runas: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - unless: test $(screen -list | grep 'rtorrent' -c) -gt 0
    - require:
      - pkg: screen

rtorrent_config:
  file.managed:
    - name: /home/{{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}/.rtorrent.rc
    - user: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - group: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - source: salt://seedbox/rtorrent/rtorrent.rc

{% if salt['file.directory_exists' ]('/media/storage/temp') %}
/media/storage/temp/downloads:
  file.directory:
    - user: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - group: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}

/media/storage/temp/downloads/complete:
  file.directory:
    - user: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - group: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}

/media/storage/temp/downloads/.session:
  file.directory:
    - user: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - group: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}


/media/storage/temp/downloads/.watch:
  file.directory:
    - user: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - group: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
{% else %}
cmd.run:
  - name: echo "Download dir does not exist"
{% endif %}
