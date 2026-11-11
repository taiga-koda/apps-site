# Koda Apps 公開サイト

Koda Apps のアプリ向けサポートページとプライバシーポリシーを置く、GitHub Pages 用の静的サイトです。

公開 URL のベース: https://taiga-koda.github.io/apps-site/

## いま公開しているページ

| ページ | URL |
| --- | --- |
| アプリ一覧（トップ） | https://taiga-koda.github.io/apps-site/ |
| シフかわ サポート（日本語） | https://taiga-koda.github.io/apps-site/shift-image/support/ |
| シフかわ プライバシーポリシー（日本語） | https://taiga-koda.github.io/apps-site/shift-image/privacy/ |
| Shifukawa Support (English) | https://taiga-koda.github.io/apps-site/shift-image/en/support/ |
| Shifukawa Privacy Policy (English) | https://taiga-koda.github.io/apps-site/shift-image/en/privacy/ |

シフかわのページ原本は private リポジトリ `taiga-koda/mobile-apps` の `apps/shift-image/store/site/` です。公開するときは、その内容をこのリポジトリの `shift-image/` へコピーします。トップのアプリ一覧（`index.html`）の正はこのリポジトリです。

## 運用

- GitHub Pages は **main ブランチのルート** から公開します。
- 作業ブランチは **dev から切る**。PR は **dev 宛て**。公開は **dev から main への PR**。
- main と dev への直接 push、force push、ブランチ削除は禁止です（保護ルールあり。必須レビュー数は 0）。
- 詳細は `AGENTS.md` を参照してください。
