# Ubuntu

## Positionnement des droits

```shell
chmod +x *.sh
```

## Installation de docker

```shell
./install_docker.sh
```

## Construction de l'image

```shell
./build.sh
```

## Lancement de l'image

```shell
./run.sh
```

## Extraire ISO

```shell
sudo mkdir /mnt/iso
sudo mount -o loop /<chemin vers l'ISO> /mnt/iso
```