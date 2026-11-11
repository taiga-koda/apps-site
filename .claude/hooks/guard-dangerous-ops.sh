#!/bin/bash
# PreToolUse(Bash) guard — main/dev 直 push と force push に対する advisory ガード。
# 権威ある enforcement は GitHub のブランチ保護。jq 不在時は fail closed。
input=$(cat)
if ! command -v jq >/dev/null 2>&1; then
  echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"guard-dangerous-ops: jq が見つからないため安全側で拒否。jq を install してください。"}}'
  exit 0
fi
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
[ -z "$cmd" ] && exit 0

deny() {
  jq -n --arg r "$1" '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$r}}'
  exit 0
}

clauses=$(printf '%s' "$cmd" | tr '\n;|&' '\n')

while IFS= read -r clause; do
  if printf '%s' "$clause" | grep -qE '^[[:space:]]*git[[:space:]]+push\b' && printf '%s' "$clause" | grep -qwE 'main'; then
    deny "main 直 push は禁止（AGENTS.md）。公開は dev から main への PR。"
  fi
  if printf '%s' "$clause" | grep -qE '^[[:space:]]*git[[:space:]]+push\b' && printf '%s' "$clause" | grep -qwE 'dev'; then
    deny "dev 直 push は禁止（AGENTS.md）。作業ブランチから dev 宛て PR を出す。"
  fi
  if printf '%s' "$clause" | grep -qE '^[[:space:]]*git[[:space:]]+push\b' && printf '%s' "$clause" | grep -qE '(^|[[:space:]])(--force|--force-with-lease|-f)([[:space:]]|=|$)'; then
    deny "force push は禁止（AGENTS.md）。"
  fi
  if printf '%s' "$clause" | grep -qE '^[[:space:]]*git[[:space:]]+' && ! printf '%s' "$clause" | grep -qE '^[[:space:]]*git[[:space:]]+commit\b' && printf '%s' "$clause" | grep -qE '(--receive-pack|--upload-pack|--exec)([[:space:]]|=)|git[[:space:]]+-c[[:space:]]'; then
    deny "git の --receive-pack / --upload-pack / --exec / -c は任意コマンド実行につながるため禁止。"
  fi
  if printf '%s' "$clause" | grep -qE '^[[:space:]]*git[[:space:]]+(reset[[:space:]]+--hard|clean[[:space:]]+-[a-z]*f)'; then
    deny "git reset --hard / git clean -f は未コミット変更を失う。対象を確認して user に許可を取ってから。"
  fi
done <<EOF
$clauses
EOF

exit 0
