## Note for Some Commands
### Scripts
1. Download large files from Google drive
```sh
sh google_drive_download.sh <file_share_id> <save_file_name>
```

2. Print 256 colors in command line
```sh
sh colour.sh
```

###

### Check NVIDIA GPU Environment
1. CUDA
```sh
$ nvcc --version | grep "release" | awk '{print $6}'
# V10.1.243
```

2. CUDnn
```sh
$ locate cudnn | grep "libcudnn.so." | tail -n1 | sed -r 's/^.*\.so\.//'
# 7.6.5
```

3. NCCL
```sh
$ locate nccl | grep "libnccl.so" | tail -n1 | sed -r 's/^.*\.so\.//'
# 2.4.8
```
