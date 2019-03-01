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

/home/{{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}.rtorrent.rc/:
  file.managed:
    - user: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - group: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - source: salt://seedbox/rtorrent/rtorrentrc

/home/{{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}/downloads/:
  file.directory:
    - user: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - group: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}

/home/{{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}/downloads/.session:
  file.directory:
    - user: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - group: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - require:
      - file: /home/{{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}/downloads/

/home/{{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}/downloads/watch/:
  file.directory:
    - user: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - group: {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}
    - require:
      - file: /home/{{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}/downloads/
      
# TODO: change about to /media/storage/temp/downloads
# TODO: need to make sure /media/storage/temp/downloads exists and make any folders along the way.
