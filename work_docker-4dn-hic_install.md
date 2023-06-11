
`work_docker-4dn-hic_install.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Install `docker-4dn-hic`](#install-docker-4dn-hic)
    1. [TBD](#tbd)
    1. [TBD](#tbd-1)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="install-docker-4dn-hic"></a>
## Install `docker-4dn-hic`
<a id="tbd"></a>
### TBD
<details>
<summary><i>Code: Clone the GitHub repository</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

ssh rhino
ml Singularity

cd ~/singularity-docker-etc
.,

singularity build 4dn-hic.sif docker://duplexa/4dn-hic:latest

singularity build 4dn-hic-v43.sif docker://duplexa/4dn-hic:v43

```
</details>
<br />

<details>
<summary><i>Printed: Clone the GitHub repository</i></summary>

```txt
❯ .,
total 4.5G
drwxrwx---  3 kalavatt  227 Dec  7 11:22 ./
drwxr-x--- 27 kalavatt 2.0K Mar  3 16:18 ../
-rwxr-x---  1 kalavatt  80M Nov 23 07:37 lolcow_latest.sif*
-rwxrwx---  1 kalavatt 365M Nov 23 09:48 my_r_container.sif*
-rw-rw----  1 kalavatt  141 Nov 23 09:14 my.r.singularity.build.def
drwxrwx---  2 kalavatt  110 Nov 23 11:51 PASA/
-rwxr-x---  1 kalavatt 418M Nov 23 12:15 PASA.sif*
-rwxr-x---  1 kalavatt 310M Nov 23 07:49 r-base-latest.sif*
-rwxr-x---  1 kalavatt 2.6G Dec  7 11:22 Trinity.sif*


❯ singularity build 4dn-hic.sif docker://duplexa/4dn-hic:latest
INFO:    Starting build...
Getting image source signatures
Copying blob b234f539f7a1 done
Copying blob 55172d420b43 done
Copying blob 5ba5bbeb6b91 done
Copying blob 43ae2841ad7a done
Copying blob f6c9c6de4190 done
Copying blob a3c14d565509 done
Copying blob 104cdd3fe490 done
Copying blob 6f19060d055e done
Copying blob b078a1d0150b done
Copying blob 58e4e142644f done
Copying blob f93ac8899220 done
Copying blob 665d0575dd39 done
Copying blob 14f433fd360d done
Copying blob 1a0690f69314 done
Copying blob 93233881b47d done
Copying blob ff0de63ceb56 done
Copying blob b01a775e98cd done
Copying blob 736476afafa5 done
Copying blob aeab406fc822 done
Copying blob aeab406fc822 skipped: already exists
Copying config 0bd79020cc done
Writing manifest to image destination
Storing signatures
2023/03/07 12:15:25  info unpack layer: sha256:b234f539f7a1d65eabae1617e63c81ac01768abffd48b5cbbf7166efca6a3429
2023/03/07 12:15:25  warn rootless{dev/agpgart} creating empty file in place of device 10:175
2023/03/07 12:15:25  warn rootless{dev/audio} creating empty file in place of device 14:4
2023/03/07 12:15:25  warn rootless{dev/audio1} creating empty file in place of device 14:20
2023/03/07 12:15:25  warn rootless{dev/audio2} creating empty file in place of device 14:36
2023/03/07 12:15:25  warn rootless{dev/audio3} creating empty file in place of device 14:52
2023/03/07 12:15:25  warn rootless{dev/audioctl} creating empty file in place of device 14:7
2023/03/07 12:15:25  warn rootless{dev/console} creating empty file in place of device 5:1
2023/03/07 12:15:25  warn rootless{dev/dsp} creating empty file in place of device 14:3
2023/03/07 12:15:25  warn rootless{dev/dsp1} creating empty file in place of device 14:19
2023/03/07 12:15:25  warn rootless{dev/dsp2} creating empty file in place of device 14:35
2023/03/07 12:15:25  warn rootless{dev/dsp3} creating empty file in place of device 14:51
2023/03/07 12:15:25  warn rootless{dev/full} creating empty file in place of device 1:7
2023/03/07 12:15:25  warn rootless{dev/kmem} creating empty file in place of device 1:2
2023/03/07 12:15:25  warn rootless{dev/loop0} creating empty file in place of device 7:0
2023/03/07 12:15:25  warn rootless{dev/loop1} creating empty file in place of device 7:1
2023/03/07 12:15:25  warn rootless{dev/loop2} creating empty file in place of device 7:2
2023/03/07 12:15:25  warn rootless{dev/loop3} creating empty file in place of device 7:3
2023/03/07 12:15:25  warn rootless{dev/loop4} creating empty file in place of device 7:4
2023/03/07 12:15:25  warn rootless{dev/loop5} creating empty file in place of device 7:5
2023/03/07 12:15:25  warn rootless{dev/loop6} creating empty file in place of device 7:6
2023/03/07 12:15:25  warn rootless{dev/loop7} creating empty file in place of device 7:7
2023/03/07 12:15:25  warn rootless{dev/mem} creating empty file in place of device 1:1
2023/03/07 12:15:25  warn rootless{dev/midi0} creating empty file in place of device 35:0
2023/03/07 12:15:25  warn rootless{dev/midi00} creating empty file in place of device 14:2
2023/03/07 12:15:25  warn rootless{dev/midi01} creating empty file in place of device 14:18
2023/03/07 12:15:25  warn rootless{dev/midi02} creating empty file in place of device 14:34
2023/03/07 12:15:25  warn rootless{dev/midi03} creating empty file in place of device 14:50
2023/03/07 12:15:25  warn rootless{dev/midi1} creating empty file in place of device 35:1
2023/03/07 12:15:25  warn rootless{dev/midi2} creating empty file in place of device 35:2
2023/03/07 12:15:25  warn rootless{dev/midi3} creating empty file in place of device 35:3
2023/03/07 12:15:25  warn rootless{dev/mixer} creating empty file in place of device 14:0
2023/03/07 12:15:25  warn rootless{dev/mixer1} creating empty file in place of device 14:16
2023/03/07 12:15:25  warn rootless{dev/mixer2} creating empty file in place of device 14:32
2023/03/07 12:15:25  warn rootless{dev/mixer3} creating empty file in place of device 14:48
2023/03/07 12:15:25  warn rootless{dev/mpu401data} creating empty file in place of device 31:0
2023/03/07 12:15:25  warn rootless{dev/mpu401stat} creating empty file in place of device 31:1
2023/03/07 12:15:25  warn rootless{dev/null} creating empty file in place of device 1:3
2023/03/07 12:15:25  warn rootless{dev/port} creating empty file in place of device 1:4
2023/03/07 12:15:25  warn rootless{dev/ram0} creating empty file in place of device 1:0
2023/03/07 12:15:25  warn rootless{dev/ram1} creating empty file in place of device 1:1
2023/03/07 12:15:25  warn rootless{dev/ram10} creating empty file in place of device 1:10
2023/03/07 12:15:25  warn rootless{dev/ram11} creating empty file in place of device 1:11
2023/03/07 12:15:25  warn rootless{dev/ram12} creating empty file in place of device 1:12
2023/03/07 12:15:25  warn rootless{dev/ram13} creating empty file in place of device 1:13
2023/03/07 12:15:25  warn rootless{dev/ram14} creating empty file in place of device 1:14
2023/03/07 12:15:25  warn rootless{dev/ram15} creating empty file in place of device 1:15
2023/03/07 12:15:25  warn rootless{dev/ram16} creating empty file in place of device 1:16
2023/03/07 12:15:25  warn rootless{dev/ram2} creating empty file in place of device 1:2
2023/03/07 12:15:25  warn rootless{dev/ram3} creating empty file in place of device 1:3
2023/03/07 12:15:25  warn rootless{dev/ram4} creating empty file in place of device 1:4
2023/03/07 12:15:25  warn rootless{dev/ram5} creating empty file in place of device 1:5
2023/03/07 12:15:25  warn rootless{dev/ram6} creating empty file in place of device 1:6
2023/03/07 12:15:25  warn rootless{dev/ram7} creating empty file in place of device 1:7
2023/03/07 12:15:25  warn rootless{dev/ram8} creating empty file in place of device 1:8
2023/03/07 12:15:25  warn rootless{dev/ram9} creating empty file in place of device 1:9
2023/03/07 12:15:25  warn rootless{dev/random} creating empty file in place of device 1:8
2023/03/07 12:15:25  warn rootless{dev/rmidi0} creating empty file in place of device 35:64
2023/03/07 12:15:25  warn rootless{dev/rmidi1} creating empty file in place of device 35:65
2023/03/07 12:15:25  warn rootless{dev/rmidi2} creating empty file in place of device 35:66
2023/03/07 12:15:25  warn rootless{dev/rmidi3} creating empty file in place of device 35:67
2023/03/07 12:15:25  warn rootless{dev/sequencer} creating empty file in place of device 14:1
2023/03/07 12:15:25  warn rootless{dev/smpte0} creating empty file in place of device 35:128
2023/03/07 12:15:25  warn rootless{dev/smpte1} creating empty file in place of device 35:129
2023/03/07 12:15:25  warn rootless{dev/smpte2} creating empty file in place of device 35:130
2023/03/07 12:15:25  warn rootless{dev/smpte3} creating empty file in place of device 35:131
2023/03/07 12:15:25  warn rootless{dev/sndstat} creating empty file in place of device 14:6
2023/03/07 12:15:25  warn rootless{dev/tty} creating empty file in place of device 5:0
2023/03/07 12:15:25  warn rootless{dev/tty0} creating empty file in place of device 4:0
2023/03/07 12:15:25  warn rootless{dev/tty1} creating empty file in place of device 4:1
2023/03/07 12:15:25  warn rootless{dev/tty2} creating empty file in place of device 4:2
2023/03/07 12:15:25  warn rootless{dev/tty3} creating empty file in place of device 4:3
2023/03/07 12:15:25  warn rootless{dev/tty4} creating empty file in place of device 4:4
2023/03/07 12:15:25  warn rootless{dev/tty5} creating empty file in place of device 4:5
2023/03/07 12:15:25  warn rootless{dev/tty6} creating empty file in place of device 4:6
2023/03/07 12:15:25  warn rootless{dev/tty7} creating empty file in place of device 4:7
2023/03/07 12:15:25  warn rootless{dev/tty8} creating empty file in place of device 4:8
2023/03/07 12:15:25  warn rootless{dev/tty9} creating empty file in place of device 4:9
2023/03/07 12:15:25  warn rootless{dev/urandom} creating empty file in place of device 1:9
2023/03/07 12:15:25  warn rootless{dev/zero} creating empty file in place of device 1:5
2023/03/07 12:15:26  info unpack layer: sha256:55172d420b43cf03feeec11bcc917c7ddfc192036102e065ab57aa9abb95311e
2023/03/07 12:15:26  info unpack layer: sha256:5ba5bbeb6b91e2676c98255c6babc66d7b05cac40185eeba4b3773199c701da0
2023/03/07 12:15:26  info unpack layer: sha256:43ae2841ad7a7fd1aeae30028105cac7f6ee0ec955e5229e52b3333fea3c17b5
2023/03/07 12:15:26  info unpack layer: sha256:f6c9c6de41905e9a66f2bc2c4a19858c8dc5b0a94f01e03eafc719afe25888aa
2023/03/07 12:15:26  info unpack layer: sha256:a3c14d56550987b63c01295ea6086c4698c6199d72a0463d2c88d93a0d91e2d2
2023/03/07 12:15:30  info unpack layer: sha256:104cdd3fe490c48a184e5f1f2da4fd0b17c932ccbb68aed89accd32c8ebaf0bc
2023/03/07 12:15:31  info unpack layer: sha256:6f19060d055e89a929d0ccd979316e59e2d758ac3010cee40eb5543d00e387c5
2023/03/07 12:15:35  info unpack layer: sha256:b078a1d0150b839bc78e577cbadded500cfb0b1843a9bb2a805e41008fdd1afe
2023/03/07 12:15:38  info unpack layer: sha256:58e4e142644faefddf730a23cef4286da02b826caec98e5651c48759a7b1f86a
2023/03/07 12:15:38  info unpack layer: sha256:f93ac88992201846441b9b0fa06b2939c9d17a8b821d0df0bcbef98fcf397d7e
2023/03/07 12:15:38  info unpack layer: sha256:665d0575dd39c9f529317f5ae70c6cfdc4b924a4a57523dbcff00d7c8349e730
2023/03/07 12:15:38  info unpack layer: sha256:14f433fd360dc1f313f5e67c470f6ef3922ceb73ee8d6e9a108cc1df7f812034
2023/03/07 12:15:39  info unpack layer: sha256:1a0690f69314c1949f7d9e07e4eb617de9149eef2cdda9282981b13716a38342
2023/03/07 12:15:42  info unpack layer: sha256:93233881b47d688d48c83728439e2c331f99129c26274b2bf7f2400434c1ff79
2023/03/07 12:15:43  info unpack layer: sha256:ff0de63ceb56c727e476ef42fcd0f203a8a7450aaeb6c25d2f3efcaae46e4228
2023/03/07 12:15:43  info unpack layer: sha256:b01a775e98cd933d0d6b063f099a25beaf37c1dd904966955f06097d7e7abecb
2023/03/07 12:15:43  info unpack layer: sha256:736476afafa5996190adc3165482844e1e3f5c04bcb78c21be977d8eb942c775
2023/03/07 12:15:51  info unpack layer: sha256:aeab406fc8226280c86599c0f4fd556290f9c4e7e2b72bfd20854348e8887338
2023/03/07 12:15:51  info unpack layer: sha256:aeab406fc8226280c86599c0f4fd556290f9c4e7e2b72bfd20854348e8887338
```
</details>
<br />

<details>
<summary><i>Code: </i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ..

d_exp="$(pwd)"
d_scr="/fh/scratch/delete30/tsukiyama_t:/loc/scratch"

singularity shell \
    --bind "${d_exp}:/data" \
    --bind "${d_scr}" \
    ~/singularity-docker-etc/4dn-hic.sif
# WARNING: Bind mount '/home/kalavatt => /home/kalavatt' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111, may not be available
```
</details>
<br />
<details>
<summary><i>Within the Singularity image</i></summary>

```txt
#!/bin/bash
#DONTRUN #CONTINUE

Singularity> pwd
/home/kalavatt


Singularity> cd /


Singularity> pwd
/


Singularity> ls -lhaFG
total 5.7M
drwxr-xr-x     1 kalavatt  100 Mar  7 12:22 ./
drwxr-xr-x     1 kalavatt  100 Mar  7 12:22 ../
lrwxrwxrwx     1 root       27 Mar  7 12:15 .exec -> .singularity.d/actions/exec*
lrwxrwxrwx     1 root       26 Mar  7 12:15 .run -> .singularity.d/actions/run*
lrwxrwxrwx     1 root       28 Mar  7 12:15 .shell -> .singularity.d/actions/shell*
drwxr-xr-x     5 root      127 Mar  7 12:15 .singularity.d/
lrwxrwxrwx     1 root       27 Mar  7 12:15 .test -> .singularity.d/actions/test*
drwxr-xr-x     2 root     1.5K Jun  6  2018 bin/
drwxr-xr-x     2 root        3 Apr 12  2016 boot/
drwxr-x---    27 kalavatt 2.0K Mar  3 16:18 data/
drwxr-xr-x    18 root     4.4K Oct  6 15:09 dev/
lrwxrwxrwx     1 root       36 Mar  7 12:15 environment -> .singularity.d/env/90-environment.sh*
drwxr-xr-x    72 root     2.2K Jun  6  2018 etc/
-rw-r--r--     1 root     1.6M Apr 24  2018 get-pip.py
drwxr-xr-x     1 kalavatt   60 Mar  7 12:22 home/
drwxr-xr-x     9 root      156 Jun  6  2018 lib/
drwxr-xr-x     2 root       43 May 25  2018 lib64/
drwxr-xr-x     3 kalavatt   60 Mar  7 12:22 loc/
drwxr-xr-x     2 root        3 May 25  2018 media/
drwxr-xr-x    14 root      293 Jun  6  2018 miniconda2/
drwxr-xr-x     2 root        3 May 25  2018 mnt/
drwxr-xr-x     2 root        3 May 25  2018 opt/
dr-xr-xr-x  4236 root        0 Sep 10 16:59 proc/
drwx------     4 root      120 Jun  6  2018 root/
drwxr-xr-x     5 root       88 Jun  6  2018 run/
drwxr-xr-x     2 root     1.5K Jun  6  2018 sbin/
lrwxrwxrwx     1 root       24 Mar  7 12:15 singularity -> .singularity.d/runscript*
drwxr-xr-x     2 root        3 May 25  2018 srv/
dr-xr-xr-x    13 root        0 Sep 21 16:33 sys/
drwxrwxrwt 17405 root     4.1M Mar  7 12:24 tmp/
drwxr-xr-x    10 root      162 May 25  2018 usr/
drwxr-xr-x    11 root      160 May 25  2018 var/


Singularity> cd bin/


Singularity> alias .,="ls -lhaFG"


Singularity> .,
total 7.9M
drwxr-xr-x 2 root      1.5K Jun  6  2018 ./
drwxr-xr-x 1 kalavatt   100 Mar  7 12:22 ../
-rwxr-xr-x 1 root     1014K May 16  2017 bash*
-rwxr-xr-x 3 root       31K May 19  2015 bunzip2*
-rwxr-xr-x 3 root       31K May 19  2015 bzcat*
lrwxrwxrwx 1 root         6 May 19  2015 bzcmp -> bzdiff*
-rwxr-xr-x 1 root      2.1K May 19  2015 bzdiff*
lrwxrwxrwx 1 root         6 May 19  2015 bzegrep -> bzgrep*
-rwxr-xr-x 1 root      4.8K May 19  2015 bzexe*
lrwxrwxrwx 1 root         6 May 19  2015 bzfgrep -> bzgrep*
-rwxr-xr-x 1 root      3.6K May 19  2015 bzgrep*
-rwxr-xr-x 3 root       31K May 19  2015 bzip2*
-rwxr-xr-x 1 root       15K May 19  2015 bzip2recover*
lrwxrwxrwx 1 root         6 May 19  2015 bzless -> bzmore*
-rwxr-xr-x 1 root      1.3K May 19  2015 bzmore*
-rwxr-xr-x 1 root       51K Mar  2  2017 cat*
-rwxr-xr-x 1 root       59K Mar  2  2017 chgrp*
-rwxr-xr-x 1 root       55K Mar  2  2017 chmod*
-rwxr-xr-x 1 root       63K Mar  2  2017 chown*
-rwxr-xr-x 1 root      148K Mar  2  2017 cp*
-rwxr-xr-x 1 root      151K Feb 17  2016 dash*
-rwxr-xr-x 1 root       67K Mar  2  2017 date*
-rwxr-xr-x 1 root       71K Mar  2  2017 dd*
-rwxr-xr-x 1 root       96K Mar  2  2017 df*
-rwxr-xr-x 1 root      124K Mar  2  2017 dir*
-rwxr-xr-x 1 root       60K Nov 30  2017 dmesg*
lrwxrwxrwx 1 root         8 Nov 24  2015 dnsdomainname -> hostname*
lrwxrwxrwx 1 root         8 Nov 24  2015 domainname -> hostname*
-rwxr-xr-x 1 root       31K Mar  2  2017 echo*
-rwxr-xr-x 1 root        28 Apr 29  2016 egrep*
-rwxr-xr-x 1 root       27K Mar  2  2017 false*
-rwxr-xr-x 1 root        28 Apr 29  2016 fgrep*
-rwxr-xr-x 1 root       49K Nov 30  2017 findmnt*
-rwxr-xr-x 1 root      207K Apr 29  2016 grep*
-rwxr-xr-x 2 root      2.3K Oct 27  2014 gunzip*
-rwxr-xr-x 1 root      5.8K Oct 27  2014 gzexe*
-rwxr-xr-x 1 root       96K Oct 27  2014 gzip*
-rwxr-xr-x 1 root       15K Nov 24  2015 hostname*
-rwxr-xr-x 1 root      368K Dec  6  2017 ip*
-rwxr-xr-x 1 root      488K Mar  8  2018 journalctl*
-rwxr-xr-x 1 root       23K May 14  2018 kill*
-rwxr-xr-x 1 root      167K Apr  5  2017 less*
-rwxr-xr-x 1 root       11K Apr  5  2017 lessecho*
lrwxrwxrwx 1 root         8 Apr  5  2017 lessfile -> lesspipe*
-rwxr-xr-x 1 root       20K Apr  5  2017 lesskey*
-rwxr-xr-x 1 root      7.6K Apr  5  2017 lesspipe*
-rwxr-xr-x 1 root       55K Mar  2  2017 ln*
-rwxr-xr-x 1 root       47K May 16  2017 login*
-rwxr-xr-x 1 root      444K Mar  8  2018 loginctl*
-rwxr-xr-x 1 root      124K Mar  2  2017 ls*
-rwxr-xr-x 1 root       76K Nov 30  2017 lsblk*
-rwxr-xr-x 1 root       76K Mar  2  2017 mkdir*
-rwxr-xr-x 1 root       63K Mar  2  2017 mknod*
-rwxr-xr-x 1 root       39K Mar  2  2017 mktemp*
-rwxr-xr-x 1 root       39K Nov 30  2017 more*
-rwsr-xr-x 1 root       40K Nov 30  2017 mount*
-rwxr-xr-x 1 root       15K Nov 30  2017 mountpoint*
-rwxr-xr-x 1 root      128K Mar  2  2017 mv*
-rwxr-xr-x 1 root      663K Mar  8  2018 networkctl*
lrwxrwxrwx 1 root         8 Nov 24  2015 nisdomainname -> hostname*
lrwxrwxrwx 1 root        14 Feb  5  2016 pidof -> /sbin/killall5*
-rwxr-xr-x 1 root       96K May 14  2018 ps*
-rwxr-xr-x 1 root       31K Mar  2  2017 pwd*
lrwxrwxrwx 1 root         4 May 16  2017 rbash -> bash*
-rwxr-xr-x 1 root       39K Mar  2  2017 readlink*
-rwxr-xr-x 1 root       59K Mar  2  2017 rm*
-rwxr-xr-x 1 root       39K Mar  2  2017 rmdir*
-rwxr-xr-x 1 root       19K Jan 26  2016 run-parts*
-rwxr-xr-x 1 root       72K Feb 11  2016 sed*
lrwxrwxrwx 1 root         4 Feb 17  2016 sh -> dash*
lrwxrwxrwx 1 root         4 Feb 17  2016 sh.distrib -> dash*
-rwxr-xr-x 1 root       31K Mar  2  2017 sleep*
-rwxr-xr-x 1 root      114K Dec  6  2017 ss*
-rwxr-xr-x 1 root       71K Mar  2  2017 stty*
-rwsr-xr-x 1 root       40K May 16  2017 su*
-rwxr-xr-x 1 root       31K Mar  2  2017 sync*
-rwxr-xr-x 1 root      645K Mar  8  2018 systemctl*
lrwxrwxrwx 1 root        20 Mar  8  2018 systemd -> /lib/systemd/systemd*
-rwxr-xr-x 1 root       51K Mar  8  2018 systemd-ask-password*
-rwxr-xr-x 1 root       39K Mar  8  2018 systemd-escape*
-rwxr-xr-x 1 root      276K Mar  8  2018 systemd-inhibit*
-rwxr-xr-x 1 root       47K Mar  8  2018 systemd-machine-id-setup*
-rwxr-xr-x 1 root       35K Mar  8  2018 systemd-notify*
-rwxr-xr-x 1 root      131K Mar  8  2018 systemd-tmpfiles*
-rwxr-xr-x 1 root       67K Mar  8  2018 systemd-tty-ask-password-agent*
-rwxr-xr-x 1 root       23K Nov 30  2017 tailf*
-rwxr-xr-x 1 root      375K Nov 17  2016 tar*
-rwxr-xr-x 1 root       11K Jan 26  2016 tempfile*
-rwxr-xr-x 1 root       63K Mar  2  2017 touch*
-rwxr-xr-x 1 root       27K Mar  2  2017 true*
-rwsr-xr-x 1 root       27K Nov 30  2017 umount*
-rwxr-xr-x 1 root       31K Mar  2  2017 uname*
-rwxr-xr-x 2 root      2.3K Oct 27  2014 uncompress*
-rwxr-xr-x 1 root      124K Mar  2  2017 vdir*
-rwxr-xr-x 1 root       31K Nov 30  2017 wdctl*
-rwxr-xr-x 1 root       946 Jan 26  2016 which*
lrwxrwxrwx 1 root         8 Nov 24  2015 ypdomainname -> hostname*
-rwxr-xr-x 1 root      1.9K Oct 27  2014 zcat*
-rwxr-xr-x 1 root      1.8K Oct 27  2014 zcmp*
-rwxr-xr-x 1 root      5.7K Oct 27  2014 zdiff*
-rwxr-xr-x 1 root       140 Oct 27  2014 zegrep*
-rwxr-xr-x 1 root       140 Oct 27  2014 zfgrep*
-rwxr-xr-x 1 root      2.1K Oct 27  2014 zforce*
-rwxr-xr-x 1 root      5.8K Oct 27  2014 zgrep*
-rwxr-xr-x 1 root      2.0K Oct 27  2014 zless*
-rwxr-xr-x 1 root      1.9K Oct 27  2014 zmore*
-rwxr-xr-x 1 root      5.0K Oct 27  2014 znew*


Singularity> cd ..


Singularity> cd /usr/local/


Singularity> .,
total 0
drwxr-xr-x 10 root  135 May 25  2018 ./
drwxr-xr-x 10 root  162 May 25  2018 ../
drwxr-xr-x 10 root 1.2K Jun  6  2018 bin/
drwxr-xr-x  2 root    3 May 25  2018 etc/
drwxr-xr-x  2 root    3 May 25  2018 games/
drwxr-xr-x  2 root    3 May 25  2018 include/
drwxr-xr-x  5 root   70 Jun  6  2018 lib/
lrwxrwxrwx  1 root    9 May 25  2018 man -> share/man/
drwxr-xr-x  2 root    3 May 25  2018 sbin/
drwxr-xr-x  7 root   85 Jun  6  2018 share/
drwxr-xr-x  2 root    3 May 25  2018 src/


Singularity> cd bin/


Singularity> .,
total 36M
drwxr-xr-x 10 root 1.2K Jun  6  2018 ./
drwxr-xr-x 10 root  135 May 25  2018 ../
drwxr-xr-x  2 root   86 Jun  6  2018 __pycache__/
lrwxrwxrwx  1 root   10 Jun  6  2018 bwa -> bwa-0.7.17/
drwxrwxr-x  3 root 1.8K Jun  6  2018 bwa-0.7.17/
-rwxr-xr-x  1 root  213 Jun  6  2018 cooler*
-rwxr-xr-x  1 root  226 Jun  6  2018 cygdb*
-rwxr-xr-x  1 root  247 Jun  6  2018 cython*
-rwxr-xr-x  1 root  227 Jun  6  2018 cythonize*
-rwxr-xr-x  1 root  480 Jun  6  2018 dill_unpickle.py*
-rw-rw-r--  1 root 2.7K Jun  6  2018 downloads.sh
-rwxr-xr-x  1 root  760 Jun  6  2018 f2py*
-rwxr-xr-x  1 root  216 Jun  6  2018 faidx*
-rwxr-xr-x  1 root 1.3K Jun  6  2018 get_objgraph.py*
drwxr-xr-x  5 root  240 Jun  6  2018 hic2cool/
drwxr-xr-x  9 root  156 Jun  6  2018 juicer/
-rw-r--r--  1 root  31M Feb  2  2018 juicer_tools.1.8.9_jcuda.0.8.jar
lrwxrwxrwx  1 root   47 Jun  6  2018 juicer_tools.jar -> /usr/local/bin/juicer_tools.1.8.9_jcuda.0.8.jar
drwxr-xr-x  3 root  119 Jun  6  2018 mcool2hic/
lrwxrwxrwx  1 root   12 Jun  6  2018 pairix -> pairix-0.3.3/
drwxrwxr-x  7 root  407 Jun  6  2018 pairix-0.3.3/
-rwxr-xr-x  1 root  215 Jun  6  2018 pairsamtools*
lrwxrwxrwx  1 root   13 Jun  6  2018 pairsqc -> pairsqc-0.2.3/
drwxrwxr-x  9 root  361 Jan 25  2018 pairsqc-0.2.3/
-rwxr-xr-x  1 root  218 Jun  6  2018 pip*
-rwxr-xr-x  1 root  218 Jun  6  2018 pip3*
-rwxr-xr-x  1 root  218 Jun  6  2018 pip3.5*
-rwxrwxr-x  1 root  239 Jun  6  2018 run-add-hicnormvector-to-mcool.sh*
-rwxrwxr-x  1 root  951 Jun  6  2018 run-addfrag2pairs.sh*
-rwxrwxr-x  1 root   73 Jun  6  2018 run-bam2pairs.sh*
-rwxrwxr-x  1 root  566 Jun  6  2018 run-bwa-mem.sh*
-rwxrwxr-x  1 root 1.5K Jun  6  2018 run-cool2multirescool.sh*
-rwxrwxr-x  1 root  241 Jun  6  2018 run-cooler-balance.sh*
-rwxrwxr-x  1 root  461 Jun  6  2018 run-cooler.sh*
-rwxrwxr-x  1 root  266 Jun  6  2018 run-fastqc.sh*
-rwxrwxr-x  1 root  254 Jun  6  2018 run-juicebox-pre-addnorm.sh*
-rwxrwxr-x  1 root 3.0K Jun  6  2018 run-juicebox-pre.sh*
-rwxrwxr-x  1 root 1.1K Jun  6  2018 run-juicer.sh*
-rwxrwxr-x  1 root   24 Jun  6  2018 run-list.sh*
-rwxrwxr-x  1 root 1.8K Jun  6  2018 run-mcool2hic.sh*
-rwxrwxr-x  1 root  870 Jun  6  2018 run-merge-pairs.sh*
-rwxrwxr-x  1 root  218 Jun  6  2018 run-pairs-patch.sh*
-rwxrwxr-x  1 root 1.3K Jun  6  2018 run-pairsam-filter.sh*
-rwxrwxr-x  1 root  717 Jun  6  2018 run-pairsam-markasdup.sh*
-rwxrwxr-x  1 root  787 Jun  6  2018 run-pairsam-merge.sh*
-rwxrwxr-x  1 root 1.5K Jun  6  2018 run-pairsam-parse-sort.sh*
-rwxrwxr-x  1 root  429 Jun  6  2018 run-pairsqc-merge.sh*
-rwxrwxr-x  1 root  420 Jun  6  2018 run-pairsqc-single.sh*
-rwxrwxr-x  1 root  136 Jun  6  2018 run-sort-bam.sh*
lrwxrwxrwx  1 root   12 Jun  6  2018 samtools -> samtools-1.2/
drwxr-xr-x  7 root 2.0K Jun  6  2018 samtools-1.2/
-rw-r--r--  1 root 4.4M May 20  2017 samtools-1.2.tar.bz2
-rw-r--r--  1 root 228K Jun  6  2018 v0.7.17.tar.gz
-rwxr-xr-x  1 root  215 Jun  6  2018 wheel*
Singularity> exit
exit
```
</details>
<br />

<a id="tbd-1"></a>
### TBD
<details>
<summary><i>Code: Install newer version, delete the older version</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

singularity build 4dn-hic-v43.sif docker://duplexa/4dn-hic:v43

rm 4dn-hic.sif
```
</details>
<br />

<details>
<summary><i>Printed: Install newer version</i></summary>

```txt
❯ singularity build 4dn-hic-v43.sif docker://duplexa/4dn-hic:v43
INFO:    Starting build...
Getting image source signatures
Copying blob 7b722c1070cd done
Copying blob 5fbf74db61f1 done
Copying blob ed41cb72e5c9 done
Copying blob 7ea47a67709e done
Copying blob c5af4c250252 done
Copying blob 8356a81adff7 done
Copying blob 1bbbe391db84 done
Copying blob dd2434ef8ad4 done
Copying blob 6d41030cf830 done
Copying blob a63b8f6430c9 done
Copying blob 0532a9d89bd4 done
Copying blob 2bead9caaa87 done
Copying blob a3ad9d536a8a done
Copying blob a27c06903ca1 done
Copying blob cabd3b317abc done
Copying blob ba63a59bbe23 done
Copying blob ef6a51cd41df done
Copying blob 015296f885ca done
Copying blob 015296f885ca skipped: already exists
Copying config ff4c706f34 done
Writing manifest to image destination
Storing signatures
2023/03/07 12:42:58  info unpack layer: sha256:7b722c1070cdf5188f1f9e43b8413157f8dfb2b4fe84db3c03cb492379a42fcc
2023/03/07 12:42:58  warn rootless{dev/agpgart} creating empty file in place of device 10:175
2023/03/07 12:42:58  warn rootless{dev/audio} creating empty file in place of device 14:4
2023/03/07 12:42:58  warn rootless{dev/audio1} creating empty file in place of device 14:20
2023/03/07 12:42:58  warn rootless{dev/audio2} creating empty file in place of device 14:36
2023/03/07 12:42:58  warn rootless{dev/audio3} creating empty file in place of device 14:52
2023/03/07 12:42:58  warn rootless{dev/audioctl} creating empty file in place of device 14:7
2023/03/07 12:42:58  warn rootless{dev/console} creating empty file in place of device 5:1
2023/03/07 12:42:58  warn rootless{dev/dsp} creating empty file in place of device 14:3
2023/03/07 12:42:58  warn rootless{dev/dsp1} creating empty file in place of device 14:19
2023/03/07 12:42:58  warn rootless{dev/dsp2} creating empty file in place of device 14:35
2023/03/07 12:42:58  warn rootless{dev/dsp3} creating empty file in place of device 14:51
2023/03/07 12:42:58  warn rootless{dev/full} creating empty file in place of device 1:7
2023/03/07 12:42:58  warn rootless{dev/kmem} creating empty file in place of device 1:2
2023/03/07 12:42:58  warn rootless{dev/loop0} creating empty file in place of device 7:0
2023/03/07 12:42:58  warn rootless{dev/loop1} creating empty file in place of device 7:1
2023/03/07 12:42:58  warn rootless{dev/loop2} creating empty file in place of device 7:2
2023/03/07 12:42:58  warn rootless{dev/loop3} creating empty file in place of device 7:3
2023/03/07 12:42:58  warn rootless{dev/loop4} creating empty file in place of device 7:4
2023/03/07 12:42:58  warn rootless{dev/loop5} creating empty file in place of device 7:5
2023/03/07 12:42:58  warn rootless{dev/loop6} creating empty file in place of device 7:6
2023/03/07 12:42:58  warn rootless{dev/loop7} creating empty file in place of device 7:7
2023/03/07 12:42:58  warn rootless{dev/mem} creating empty file in place of device 1:1
2023/03/07 12:42:58  warn rootless{dev/midi0} creating empty file in place of device 35:0
2023/03/07 12:42:58  warn rootless{dev/midi00} creating empty file in place of device 14:2
2023/03/07 12:42:58  warn rootless{dev/midi01} creating empty file in place of device 14:18
2023/03/07 12:42:58  warn rootless{dev/midi02} creating empty file in place of device 14:34
2023/03/07 12:42:58  warn rootless{dev/midi03} creating empty file in place of device 14:50
2023/03/07 12:42:58  warn rootless{dev/midi1} creating empty file in place of device 35:1
2023/03/07 12:42:58  warn rootless{dev/midi2} creating empty file in place of device 35:2
2023/03/07 12:42:58  warn rootless{dev/midi3} creating empty file in place of device 35:3
2023/03/07 12:42:58  warn rootless{dev/mixer} creating empty file in place of device 14:0
2023/03/07 12:42:58  warn rootless{dev/mixer1} creating empty file in place of device 14:16
2023/03/07 12:42:58  warn rootless{dev/mixer2} creating empty file in place of device 14:32
2023/03/07 12:42:58  warn rootless{dev/mixer3} creating empty file in place of device 14:48
2023/03/07 12:42:58  warn rootless{dev/mpu401data} creating empty file in place of device 31:0
2023/03/07 12:42:58  warn rootless{dev/mpu401stat} creating empty file in place of device 31:1
2023/03/07 12:42:58  warn rootless{dev/null} creating empty file in place of device 1:3
2023/03/07 12:42:58  warn rootless{dev/port} creating empty file in place of device 1:4
2023/03/07 12:42:58  warn rootless{dev/ram0} creating empty file in place of device 1:0
2023/03/07 12:42:58  warn rootless{dev/ram1} creating empty file in place of device 1:1
2023/03/07 12:42:58  warn rootless{dev/ram10} creating empty file in place of device 1:10
2023/03/07 12:42:58  warn rootless{dev/ram11} creating empty file in place of device 1:11
2023/03/07 12:42:58  warn rootless{dev/ram12} creating empty file in place of device 1:12
2023/03/07 12:42:58  warn rootless{dev/ram13} creating empty file in place of device 1:13
2023/03/07 12:42:58  warn rootless{dev/ram14} creating empty file in place of device 1:14
2023/03/07 12:42:58  warn rootless{dev/ram15} creating empty file in place of device 1:15
2023/03/07 12:42:58  warn rootless{dev/ram16} creating empty file in place of device 1:16
2023/03/07 12:42:58  warn rootless{dev/ram2} creating empty file in place of device 1:2
2023/03/07 12:42:58  warn rootless{dev/ram3} creating empty file in place of device 1:3
2023/03/07 12:42:58  warn rootless{dev/ram4} creating empty file in place of device 1:4
2023/03/07 12:42:58  warn rootless{dev/ram5} creating empty file in place of device 1:5
2023/03/07 12:42:58  warn rootless{dev/ram6} creating empty file in place of device 1:6
2023/03/07 12:42:58  warn rootless{dev/ram7} creating empty file in place of device 1:7
2023/03/07 12:42:58  warn rootless{dev/ram8} creating empty file in place of device 1:8
2023/03/07 12:42:58  warn rootless{dev/ram9} creating empty file in place of device 1:9
2023/03/07 12:42:58  warn rootless{dev/random} creating empty file in place of device 1:8
2023/03/07 12:42:58  warn rootless{dev/rmidi0} creating empty file in place of device 35:64
2023/03/07 12:42:58  warn rootless{dev/rmidi1} creating empty file in place of device 35:65
2023/03/07 12:42:58  warn rootless{dev/rmidi2} creating empty file in place of device 35:66
2023/03/07 12:42:58  warn rootless{dev/rmidi3} creating empty file in place of device 35:67
2023/03/07 12:42:58  warn rootless{dev/sequencer} creating empty file in place of device 14:1
2023/03/07 12:42:58  warn rootless{dev/smpte0} creating empty file in place of device 35:128
2023/03/07 12:42:58  warn rootless{dev/smpte1} creating empty file in place of device 35:129
2023/03/07 12:42:58  warn rootless{dev/smpte2} creating empty file in place of device 35:130
2023/03/07 12:42:58  warn rootless{dev/smpte3} creating empty file in place of device 35:131
2023/03/07 12:42:58  warn rootless{dev/sndstat} creating empty file in place of device 14:6
2023/03/07 12:42:58  warn rootless{dev/tty} creating empty file in place of device 5:0
2023/03/07 12:42:58  warn rootless{dev/tty0} creating empty file in place of device 4:0
2023/03/07 12:42:58  warn rootless{dev/tty1} creating empty file in place of device 4:1
2023/03/07 12:42:58  warn rootless{dev/tty2} creating empty file in place of device 4:2
2023/03/07 12:42:58  warn rootless{dev/tty3} creating empty file in place of device 4:3
2023/03/07 12:42:58  warn rootless{dev/tty4} creating empty file in place of device 4:4
2023/03/07 12:42:58  warn rootless{dev/tty5} creating empty file in place of device 4:5
2023/03/07 12:42:58  warn rootless{dev/tty6} creating empty file in place of device 4:6
2023/03/07 12:42:58  warn rootless{dev/tty7} creating empty file in place of device 4:7
2023/03/07 12:42:58  warn rootless{dev/tty8} creating empty file in place of device 4:8
2023/03/07 12:42:58  warn rootless{dev/tty9} creating empty file in place of device 4:9
2023/03/07 12:42:58  warn rootless{dev/urandom} creating empty file in place of device 1:9
2023/03/07 12:42:58  warn rootless{dev/zero} creating empty file in place of device 1:5
2023/03/07 12:42:59  info unpack layer: sha256:5fbf74db61f1459176d8647ba8f53f8e6cf933a2e56f73f0e8da81213117b7e9
2023/03/07 12:42:59  info unpack layer: sha256:ed41cb72e5c918bdbd78e68f02930a3f1cf1d6079402b0a5b19de8508e67b766
2023/03/07 12:42:59  info unpack layer: sha256:7ea47a67709ebea8efed59fbda703dbd00a0d2cae7e2808959744bfa30bfc0e9
2023/03/07 12:42:59  info unpack layer: sha256:c5af4c250252bd7a61c8f1eb28ac9f1b9c82973c432839ef104c3a4a75aa6085
2023/03/07 12:43:03  info unpack layer: sha256:8356a81adff7d3f6e985d098537a7df9cff2b4124e02d890843e07c9f9dc4f6e
2023/03/07 12:43:04  info unpack layer: sha256:1bbbe391db8445713d52ae847466c2cf50eacc5c44ad85e506b06ff3f3a94f4a
2023/03/07 12:43:07  info unpack layer: sha256:dd2434ef8ad4bca31347fa01fae0c20b6facd5b44b7889c258a48cb9542507f9
2023/03/07 12:43:11  info unpack layer: sha256:6d41030cf83010e3db290ac0f7a32a4f6cc47ad0f571cbc3c13e812df8a9d154
2023/03/07 12:43:11  info unpack layer: sha256:a63b8f6430c90b8c9e8a6f0de406dbcc83e145c5e0be7738f4512844f69b0977
2023/03/07 12:43:11  info unpack layer: sha256:0532a9d89bd40b60dc9117faef4610135c64a00ac0a8b29eca7b7fae590c20b8
2023/03/07 12:43:11  info unpack layer: sha256:2bead9caaa8790cfc5fb2f5276c1df4fa757d8f2c836be9909611ec6305433df
2023/03/07 12:43:12  info unpack layer: sha256:a3ad9d536a8a2f84fb3a375bae4aaaa2e227356751306d6508a467678ceae055
2023/03/07 12:43:18  info unpack layer: sha256:a27c06903ca18409f6011e8d0aa93e83f3866068a483850cfcf504bdf7307ffc
2023/03/07 12:43:18  info unpack layer: sha256:cabd3b317abcf7275e45e8652f6fbfb25f9d6c959354239137ba5258fc5974fe
2023/03/07 12:43:19  info unpack layer: sha256:ba63a59bbe23d1c34cb16e375a08b479ac9c23672113b237c6c6cb493ab1587d
2023/03/07 12:43:19  info unpack layer: sha256:ef6a51cd41dfeb7d029dfea3739ab80419e5676643603e6c3d28aa1fb7d8666a
2023/03/07 12:43:26  info unpack layer: sha256:015296f885ca7c771e746e5b16ae1f741cb05749c9a82b6e15116eafc7c31329
2023/03/07 12:43:26  info unpack layer: sha256:015296f885ca7c771e746e5b16ae1f741cb05749c9a82b6e15116eafc7c31329
INFO:    Creating SIF file...
INFO:    Build complete: 4dn-hic-v43.sif


❯ rm 4dn-hic.sif
```
</details>
<br />

<details>
<summary><i>Code: </i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}"

singularity exec \
    ~/singularity-docker-etc/4dn-hic-v43.sif \
        run-list.sh
```
</details>
<br />


<details>
<summary><i>Code: Clone GitHub repo</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ~/tsukiyamalab/kalavatt/2023_rDNA/software

git clone https://github.com/4dn-dcic/docker-4dn-hic
```
</details>
<br />

<details>
<summary><i>Printed: Clone GitHub repo</i></summary>

```txt
❯ cd ~/tsukiyamalab/kalavatt/2023_rDNA/software

❯ git clone https://github.com/4dn-dcic/docker-4dn-hic
Cloning into 'docker-4dn-hic'...
remote: Enumerating objects: 5130, done.
remote: Total 5130 (delta 0), reused 0 (delta 0), pack-reused 5130
Receiving objects: 100% (5130/5130), 539.56 MiB | 22.89 MiB/s, done.
Resolving deltas: 100% (3655/3655), done.
Checking out files: 100% (111/111), done.
```
</details>
<br />
