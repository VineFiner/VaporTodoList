#!/bin/sh

# 当前目录
echo $PWD

# 拷贝所有运行时
#docker run --rm \
#-v "$PWD:/workspace" \
#-w /workspace \
#swift:5.5.1-centos7  \
#/bin/bash -cl ' \
#     swift build -c release && \
#     rm -rf .build/install && mkdir -p .build/install && \
#     cp -P .build/release/Run .build/install/ && \
#     cp -P /usr/lib/swift/linux/lib*so* .build/install/'

# 构建并拷贝所需运行时

docker run --rm \
-v "$PWD:/workspace" \
-w /workspace \
swift:5.5.1-centos7  \
/bin/bash -cl " \
     yum remove git -y && \
     yum install https://repo.ius.io/ius-release-el7.rpm -y && \
     yum install git224 -y && \
     yum install -y sqlite-devel && \
     swift build -c release && \
     rm -rf .build/install && mkdir -p .build/install && \
     cp -P .build/release/Run .build/install/ && \
     ldd .build/install/Run | grep swift | awk '{print $3}' | xargs cp -Lv -t .build/install/"

# build end

# 压缩代码包

# 上传

