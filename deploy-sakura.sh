#!/bin/bash
# さくらサーバーへ tesou-lp をアップロードするスクリプト
#
# 使い方:
#   1. 以下の変数を編集するか、環境変数で指定
#   2. chmod +x deploy-sakura.sh
#   3. ./deploy-sakura.sh
#
# 必要なもの: lftp（macOS では brew install lftp）

set -e

# === 接続情報（環境変数で上書き可能）===
SAKURA_HOST="${SAKURA_HOST:-yui-uranai.sakura.ne.jp}"
SAKURA_USER="${SAKURA_USER:-}"  # FTPユーザー名を指定
SAKURA_PASS="${SAKURA_PASS:-}"   # パスワード（未指定の場合は実行時に入力）
REMOTE_DIR="${SAKURA_REMOTE_DIR:-www/kantei-menu}"  # リモートのパス（デフォルト: kantei-menu サブフォルダ）
USE_SFTP="${SAKURA_SFTP:-0}"     # 1 の場合 SFTP を使用（さくらは通常 FTP）

# プロジェクトのルート（スクリプトの場所）
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

if [ -z "$SAKURA_USER" ]; then
  echo "エラー: FTPユーザー名を設定してください。"
  echo "  export SAKURA_USER=your_ftp_username"
  echo "  または、このスクリプト内の SAKURA_USER を編集してください。"
  exit 1
fi

if [ -z "$REMOTE_DIR" ]; then
  REMOTE_DIR="www/kantei-menu"
fi

echo "=== さくらサーバーへデプロイ ==="
echo "ホスト: $SAKURA_HOST"
echo "ユーザー: $SAKURA_USER"
echo "リモート: $REMOTE_DIR"
echo ""

# lftp の存在確認
if ! command -v lftp &> /dev/null; then
  echo "lftp がインストールされていません。"
  echo "macOS の場合: brew install lftp"
  exit 1
fi

# index.html と images/ を kantei-menu サブフォルダへアップロード
# （www/kantei-menu が存在しない場合、初回は FTP ソフトで kantei-menu フォルダを作成してください）
LFTP_CMDS="
  set ftp:ssl-allow no;
  set ssl:verify-certificate no;
  cd $REMOTE_DIR;
  lcd $SCRIPT_DIR;
  put -O . index.html;
  mirror -R -v images images;
  quit
"

# アップロード実行
if [ -n "$SAKURA_PASS" ]; then
  lftp -u "$SAKURA_USER","$SAKURA_PASS" -e "$LFTP_CMDS" "ftp://$SAKURA_HOST"
else
  echo "パスワードを入力してください（SAKURA_PASS で指定すると省略可能）:"
  lftp -u "$SAKURA_USER" -e "$LFTP_CMDS" "ftp://$SAKURA_HOST"
fi

echo ""
echo "デプロイ完了: https://${SAKURA_HOST}/kantei-menu/"
