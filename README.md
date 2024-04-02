# STUDY METHODS
URL:https://study-methods.com/
<img width="1114" alt="スクリーンショット 2024-03-24 15 33 12" src="https://github.com/tomosawako/study-methods/assets/145893964/b07c26ca-fdf5-4a4a-b137-588d9610c97f" width="100">
​
## サイト概要
### サイトテーマ
様々な資格や科目の勉強方法を検索したり、勉強の成果を投稿したりできるコミュニティサイト
​
### テーマを選んだ理由
教師として働いているのですが、勉強しているのに得点が取れない、取りたい資格があるが勉強方法が分からないという生徒に数多く会ってきました。<br>
学生に限らず世の中の勉強したい人が成果が合った他の人の勉強方法を手軽に知ることができたら便利だと考えました。<br>
また、学習方法を知るだけでなく、同じ様に勉強を頑張っている人同士の励まし合いにもなると考え、このテーマに設定しました。
​
### ターゲットユーザ
- 中学生〜高校生
- 資格取得や受験勉強に向けて勉強を頑張りたい人
​
### 主な利用シーン
- 苦手な科目がありなかなか得点が上がらず困っている時
- 取りたい資格があり、効率的な勉強方法を知りたい人
​
## 機能
-  実装機能リスト
https://docs.google.com/spreadsheets/d/1W6Ha4vVhzdI5AfPDitvXUZ0pDcszvGj9VKzZ-sjgKCk/edit?usp=sharing
- 新規登録、ログイン、ログアウト、ゲストログイン
- いいね機能
- コメント機能
- コメント返信機能
- コメント管理機能(管理者)
- 投稿機能
- 投稿検索(キーワード検索)
- 投稿検索機能(タグ(科目・資格)検索)
- マイページ機能
- ユーザー管理機能(管理者)
- 投稿ランキング機能

## 設計書
- ER図
![study_methods_er drawio](https://github.com/tomosawako/study-methods/assets/145893964/631abb2b-358f-4d2e-aadb-5fc9aaa96d63)
- 画面遷移図(https://drive.google.com/file/d/1IrdZwuh55mgqtuHscD8YUKUuDJB49wLD/view?usp=sharing)
- ワイヤーフレーム<br>
エンドユーザー(https://drive.google.com/file/d/1OKiMWplND_ZkvwRhAuNLg9ZNS2N3vDKP/view?usp=sharing)<br>
管理者(https://drive.google.com/file/d/1M7s6RHHePjJBf45sTugOMorqA-3LLjr9/view?usp=sharing)
- テーブル定義書(https://docs.google.com/spreadsheets/d/148t5LRsqVWieLjbq1l_vBYQghlfzmhRAVXW-KPdXEbY/edit?usp=sharing)
- 詳細設計(https://docs.google.com/spreadsheets/d/1rj2ai3D-Y0jV-Wq96S3AAM--1T3p03kndCOm8xZOeJM/edit?usp=sharing)
- AWS構成図
<img width="767" alt="スクリーンショット 2024-04-02 14 39 52" src="https://github.com/tomosawako/study-methods/assets/145893964/80048a3f-d73d-4f18-a4b7-699ea41410a9" width="100">

## 開発環境
- OS：Amazon Linux 2
- 言語：HTML/CSS,JavaScript,Ruby,SQL
- フレームワーク/ライブラリ：Ruby on Rails,Bootstrap,Rspec
- インフラ：AWS(EC2/EIP/AMI/RDS/Route53/),Ngninx,puma
- IDE：Cloud9
​
## 使用素材
フリーイラスト素材として以下を使用
- ぱくたそ (https://www.pakutaso.com/)
- O-DAN(https://o-dan.net/ja/)
ロゴ作成素材として以下を使用
- designevo(https://www.designevo.com/)