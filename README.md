# Ubuntu

## Installation de docker

```shell
sudo apt update
sudo apt install -y docker.io
```

Si besoin

```shell
sudo ip link add name docker0 type bridge
sudo ip addr add dev docker0 172.17.0.1/16
```

## Positionnement des droits

```shell
chmod +x *.sh
```

## Construction de l'image

```shell
./build.sh
```

## Lancement de l'image

```shell
./run.sh
```