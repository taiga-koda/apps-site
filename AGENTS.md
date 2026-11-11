# AGENTS.md

Koda Apps の公開サイト（GitHub Pages）リポジトリ。静的 HTML のみ。やり取りとドキュメントは日本語。

`CLAUDE.md` はこのファイルへのシンボリックリンクです。ルールの正本は `AGENTS.md` だけです。

## このリポジトリの役割

- 公開 URL のベースは `https://taiga-koda.github.io/apps-site/`。
- GitHub Pages は **main ブランチのルート** から公開する。
- 各アプリのサポート／プライバシーポリシーは `<app-slug>/support/` と `<app-slug>/privacy/`（英語は `<app-slug>/en/support/` と `<app-slug>/en/privacy/`）。
- シフかわ（`shift-image/`）のページ原本は private リポジトリ `taiga-koda/mobile-apps` の `apps/shift-image/store/site/`。公開時にここへコピーする。トップのアプリ一覧（`index.html`）の正はこのリポジトリ。
- 解析タグ、Cookie、外部フォント、外部スクリプトは足さない。CSS はリポジトリ内のファイルだけを使う。

## 文言

- 「オフライン」「完全オフライン」とは書かない。承認済みの表現は「写真・文章・書類は端末内で扱い、こちらへは送りません」（必要なら「広告・購入確認の SDK は通信することがあります」）。
- 運営者名は `Koda Apps`、問い合わせは `kodaapps.support@gmail.com`。
- 秘密情報（キー、パスワード、`.env`、キーストア）をコミットしない。公開してよいのはポリシー・サポートに載せる連絡先と URL だけ。

## Git 運用

- 作業ブランチは **dev から切る**。PR は **dev 宛て**。
- 公開（Pages に出す変更）は **dev から main への PR** で行う。
- **main と dev への直接 push、force push、ブランチの削除は禁止**。必須レビュー数は 0（自分の PR をマージしてよい）。
- 空のリポジトリへの初回コミットを main へ push したあとは、この運用に従う。

## エージェント向けの配置

mobile-apps / digital-products と同じ形です。

- `.claude/skills/` が正で、`.agents/skills`・`.codex/skills`・`.cursor/skills` はそこへのシンボリックリンク。
- `.cursor/rules/coding-rule.mdc` は Cursor 用の短いルール（詳細は本ファイル）。
- `.claude/settings.json` と `.claude/hooks/guard-dangerous-ops.sh` で、main/dev への直接 push と force push を拒む。
