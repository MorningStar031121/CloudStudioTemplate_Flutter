#!/bin/bash
set -e

echo "正在更新软件包..."
apt update
apt upgrade -y

echo "正在安装依赖..."
apt install -y clang cmake libgtk-3-dev

FLUTTER_VERSION="3.29.3"
FLUTTER_DIR="/Flutter/FlutterSDK"
FLUTTER_DOWNLOAD="/Flutter/flutter.tar.xz"

echo "创建Flutter安装目录..."
mkdir -p "$FLUTTER_DIR"

echo "配置环境变量..."
cat <<EOT >> ~/.zshrc
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
export PATH="$FLUTTER_DIR/bin:\$PATH"
EOT

# 直接设置当前环境变量
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
export PATH="$FLUTTER_DIR/bin:$PATH"

echo "正在下载FlutterSDK $FLUTTER_VERSION..."
wget "https://storage.flutter-io.cn/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" -O "$FLUTTER_DOWNLOAD"

echo "正在解压FlutterSDK..."
tar -xf "$FLUTTER_DOWNLOAD" -C "$FLUTTER_DIR" --strip-components=1

echo "初始化Flutter并检查工具链..."
flutter doctor -v

echo "创建示例项目..."
cd /workspace
flutter create MyProject

echo "清理安装包..."
rm "$FLUTTER_DOWNLOAD"

echo -e "\n\033[32mInstallation completed!\033[0m"
echo "请手动执行以下命令或重启终端使环境变量生效："
echo "source ~/.zshrc"
echo "请使用编辑器的文件打开项目文件夹"
