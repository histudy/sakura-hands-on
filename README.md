# さくらクラウドハンズオン
さくらクラウドハンズオン用のリポジトリです

ハンズオンへの参加申し込み
----------------------------------

以下のページより、参加申し込みをお願いします。

[加古川IT系インフラ勉強会 2017.02 さくらクラウドハンズオン](https://histudy.connpass.com/event/47404/)

ハンズオンの内容
----------------------------------

### 初級編

* 管理画面の利用方法
* 各用語の解説
* 運用上の注意事項とTips

### 中級編

[Vagrant](https://www.vagrantup.com/)を利用し、さくらのクラウド上にLAMP(Linux + Apache + MyAQL + PHP)環境を構築

ハンズオンに必要なもの
----------------------------------

**中級編**に参加をご希望の場合は、
ハンズオンで利用するPC( Windows / mac/ Linux )に、  
以下のアプリケーションがインストールされている必要があります。

* [Vagrant](https://www.vagrantup.com/)
* [Vagrant Sakura Provider](https://github.com/tsahara/vagrant-sakura)

また、Windowsを利用される場合は、上記のアプリケーションに加え、  
rsyncコマンドがインストールされ、rsyncにパスが通っている必要があります。

- サーバー構築用プログラムをさくらクラウド上のサーバーに転送するために必要になります。  
- [Chocolatey](https://chocolatey.org/)などを利用することにより、比較的簡単にrsyncコマンドをインストールすることが出来ます。

リポジトリのディレクトリ構成の概要や、Windowsでのセットアップ例に関しては、  
[Wiki](https://github.com/histudy/sakura-hands-on/wiki)を参照してください。


### 注意事項

このリポジトリのプロビジョニング処理は、  
[さくらのクラウド](http://cloud.sakura.ad.jp/)のCentOS 7以降のパブリックアーカイブを利用することを前提に記載されています。  
パブリックアーカイブの指定を変更された場合は、  
正常に動作しない可能性があります。

CentOS 7のパブリックアーカイブの仕様に関しては、  
公式サイトを参照してください。

[CentOS 7.3 (1611) 64bit リリースノート](http://cloud-news.sakura.ad.jp/public_archive_iso/centos73-releasenote/)

License
----------------------------------

MIT License
