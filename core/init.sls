include:
  - core.aide
  - core.htop
  - core.mplayer
  - core.ssh.server
  - core.vim
  - core.salt

/etc/default/grub:
  file.replace:
    - pattern: 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"'
    - repl: 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash radeon.audio=1"'

update-grub:
  cmd.wait: 
    - name: update-grub
    - watch:
      - file: /etc/default/grub
