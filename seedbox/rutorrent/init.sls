/var/www/:
  file.directory:
    - user: www-data
    - group: www-data
  archive.extracted:
    # NEED TO change name of output folder to "rutorrent"
    - source: salt://seedbox/rutorrent/rutorrent-3.8.tar.gz
    - user: www-data
    - group: www-data

rutorrent:
  pkg.installed:
    - names:
      - php7.2-fpm
      - php7.2-cli
      - php-geoip
      - nginx
      - apache2-utils
      - byobu

/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://seedbox/rutorrent/ru_torrent_nginx.conf
    - user: root

/var/www/rutorrent/.htpasswd:
  file.managed:
    - source: salt://seedbox/rutorrent/.htpasswd
    - user: www-data
    - group: www-data

www-data:
  group.present:
    - addusers:
      - {{ salt['pillar.get']('users:johnny:username', 'johnnyg') }}

/var/www/rutorrent/conf/config.php:
  file.managed:
    - source: salt://seedbox/rutorrent/config.php
    - user: www-data
    - group: www-data
