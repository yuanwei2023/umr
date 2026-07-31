
PID=$1
GPU=0001:c9:00.0
VMP=1
OUT=./all-queues-dump-$PID

mkdir -p "$OUT"

sudo /usr/local/bin/umr \
  --by-pci "$GPU" -vmp "$VMP" --list-uq |
  tee "$OUT/list-uq.log"

awk -v pid="$PID" '
  /^Client #:/ {
    active = index($0, "tgid=" pid " ") != 0
  }
  active && /queue=[0-9]+/ {
    for (i=1; i<=NF; i++) {
      if ($i ~ /^queue=/) {
        sub(/^queue=/, "", $i)
        print $i
      }
    }
  }
' "$OUT/list-uq.log" |
while read -r q; do
  echo "Dump PID=$PID queue=$q"

  sudo /usr/local/bin/umr \
    --by-pci "$GPU" -vmp "$VMP" \
    -O use_full_user_queue \
    --user-queue "kfd,pid=$PID,queue=$q" \
    --dump-uq > "$OUT/queue-$q.log"
done
