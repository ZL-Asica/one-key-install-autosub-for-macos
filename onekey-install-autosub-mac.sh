#!/bin/sh
#
# onekey install autosub For macOS
# 一键安装autosub For macOS
#
# System Required:  macOS
#
# Copyright (C) 2019-2020 ZL Asica <zl@zla.moe>
#
# URL: https://www.zla.moe/
#

red='\033[0;31m'
plain='\033[0m'

[[ $EUID -eq 0 ]] && echo -e "${red}错误:${plain} 此脚本请勿使用root账户(sudo)运行,运行期间在需要时我会向你请求输入密码!" && exit 1

clear
#开始安装
start(){
    brew
    if [ $? -eq 0 ]; then
        clear
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    brew install ffmpeg
    ffmpeg
    if [ $? -eq 0 ]; then
        clear
        echo "下一步需要获取你的root权限，请输入你的电脑密码，输入期间不会显示，输入完成后回车即可"
    else
        echo "homebrew或ffmpeg安装失败，建议重试或联系ZL Asica" && exit 1
    fi
    sudo easy_install pip
    sudo pip3 install autosub
    autosub
    if [ $? -eq 0 ]; then
        clear
    else
        echo "autosub安装失败，建议重试或联系ZL Asica" && exit 1
    fi
    echo "----------------------------------------"
    echo "autosub已安装完成(Complete!)"
    echo "使用方式:autosub -S en -D en input.mp4"
    echo "在你的媒体文件目录下运行此命令"
    echo "-S 后为媒体源语言，-D 后为导出语言，input.mp4可以替换为你的视频(音频)文件名"
    echo "--------------- 联系我 -------------------"
    echo "有任何问题欢迎通过邮箱给我反馈"
    echo "也欢迎访问我的博客 https://www.zl-asica.com/"
    echo "zl@zla.moe"
}

echo "------------ 脚本信息 ---------------------"
echo "ZL Asica的autosub一键安装脚本For macOS(V1.0)"
echo "本脚本仅适用于macOS"
echo "若安装过程中要求你输入密码，请输入你的电脑密码，输入期间不会显示，输入完成后回车即可"
echo "By-ZL Asica"
echo "我的博客: https://www.zl-asica.com/"
echo "------------ 操作提示 ---------------------"
echo "请键入y以继续，n以结束，或你可以直接摁下 Ctrl+C 以退出"
read -p "y/n:" choice
case $choice in
	"y")
	start
	;;
	"n")
	exit 0;
	;;
	*)
	echo "请键入单字母 y 或 n!"
	;;
esac
