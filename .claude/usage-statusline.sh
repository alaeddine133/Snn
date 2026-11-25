#!/usr/bin/env bash
# Status line: usage limit (5h + 7d) and pace vs. time elapsed in each window.
# Pace = used% - elapsed%. Positive = ahead (consuming faster than the clock), negative = behind (margin left).
in=$(cat)
now=$(date +%s)

pace() { # $1=label $2=used% $3=resets_at(epoch s) $4=window length (s)
  [ -z "$2" ] && return
  local elapsed=$(( 100 - ( ($3 - now) * 100 / $4 ) ))
  (( elapsed < 0 )) && elapsed=0; (( elapsed > 100 )) && elapsed=100
  local used=${2%.*} d=$(( ${2%.*} - elapsed )) color=32 tag="en retard"
  (( d > 0 )) && { color=31; tag="en avance"; }
  local left=$(( ($3 - now) / 60 ))
  printf '%s %s%% \033[%sm(%s %+d%%)\033[0m reset %dh%02d  ' "$1" "$used" "$color" "$tag" "$d" $((left/60)) $((left%60))
}

pace 5h "$(jq -r '.rate_limits.five_hour.used_percentage // empty' <<<"$in")" \
        "$(jq -r '.rate_limits.five_hour.resets_at // 0' <<<"$in")" 18000
pace 7j "$(jq -r '.rate_limits.seven_day.used_percentage // empty' <<<"$in")" \
        "$(jq -r '.rate_limits.seven_day.resets_at // 0' <<<"$in")" 604800
