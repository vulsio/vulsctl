## Vulsctl

[Vulsctl](https://github.com/vulsio/vulsctl) was created to ease setup for [Vuls](https://github.com/future-architect/vuls). Each shell script is a wrapper for docker command.

## setup Docker

- Install [Docker](https://docs.docker.com/install/linux/docker-ce/centos/)
- [Manage Docker as a non-root user](https://docs.docker.com/install/linux/linux-postinstall/)

```bash
$ sudo systemctl start docker
```

## Clone Vulsctl

```bash
$ git clone https://github.com/vulsio/vulsctl.git
$ cd vulsctl
```

## Fetch Vulnerability Database

```
$ ./update-all.sh
```

## Scan and Report

Prepare config.toml in the same directory.

```
$ cat $HOME/vulsctl/config.toml 
[servers]
[servers.hostos]
host        = "52.10.10.10"
port        = "22"
user        = "centos"
# keypath in the Vuls docker container
keyPath     = "/root/.ssh/id_rsa"
```

SSH before scanning to add fingerprint to $HOME/.ssh/known_hosts on the Docker host.
```
$ ssh centos@52.100.100.100 -i ~/.ssh/id_rsa.pem
```

```
$ ./scan.sh 
$ ./report.sh
$ ./tui.sh
```

For details, see
- [scan.sh](https://github.com/vulsio/vulsctl/blob/master/scan.sh)
- [report.sh](https://github.com/vulsio/vulsctl/blob/master/report.sh)
- [tui.sh](https://github.com/vulsio/vulsctl/blob/master/tui.sh)

