include:
  - core.ssh
  - core.pillar
  - core.salt
  - core.htop
  - core.mplayer
  - core.vim
  - core.byobu

/etc/default/grub:
  file.replace:
    - pattern: 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"'
    - repl: 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash radeon.audio=1"'

update-grub:
  cmd.wait: 
    - name: update-grub
    - watch:
      - file: /etc/default/grub
