# さくら Webファイルマネージャーでアップロードする手順

FTPソフトがなくても、ブラウザだけでアップロードできます。

---

## 準備：ZIPファイル

`deploy-kantei-menu.zip` を次の場所で開いてください。

```
/Users/yui/Documents/cursor/tesou-lp/deploy-kantei-menu.zip
```

（Finder で `tesou-lp` フォルダを開くと見つかります）

---

## 手順

### 1. さくらコントロールパネルにログイン

1. [https://secure.sakura.ad.jp/](https://secure.sakura.ad.jp/) にアクセス
2. 契約者IDとパスワードでログイン

### 2. ファイルマネージャーを開く

1. **「サイト」** または **「ウェブ」** をクリック
2. **「ファイルマネージャー」** をクリック

### 3. kantei-menu フォルダを作成

1. 左側で **`www`**（または Web 公開フォルダ）をクリック
2. **「新規フォルダ作成」** をクリック
3. フォルダ名に **`kantei-menu`** と入力して作成
4. **`kantei-menu`** フォルダを開く

### 4. ZIP をアップロードして解凍

1. **「ファイルをアップロード」** をクリック
2. **`deploy-kantei-menu.zip`** を選択してアップロード
3. アップロード後、**`deploy-kantei-menu.zip`** を右クリック
4. **「解凍」** を選択
5. 解凍が終わったら、`deploy-kantei-menu.zip` は削除して構いません

### 5. 解凍後の構成確認

`kantei-menu` フォルダ内が次のようになっていればOKです：

```
kantei-menu/
├── index.html
└── images/
    ├── profile.png
    └── hero-mystic.png
```

---

## 完了

**https://yui-uranai.sakura.ne.jp/kantei-menu/** にアクセスして表示を確認してください。
