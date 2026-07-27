
UMR=./src/app/umr
GPU=0001:c9:00.0
VMP=1
OUT=/tmp/umr-sdma-queues

mkdir -p "$OUT"

sudo "$UMR" --by-pci "$GPU" -vmp "$VMP" --list-uq |
    tee "$OUT/list-uq.log"

awk '
/^Client #:/ {
    line=$0
    sub(/^.*tgid=/, "", line)
    pid=line
    sub(/ .*/, "", pid)
}
pid && /queue=[0-9]+ type=3/ {
    line=$0
    sub(/^.*queue=/, "", line)
    queue=line
    sub(/ .*/, "", queue)
    print pid, queue
}' "$OUT/list-uq.log" |
while read -r pid queue; do
    echo "Dump PID=$pid SDMA queue=$queue"

    sudo "$UMR" \
        --by-pci "$GPU" \
        -vmp "$VMP" \
        -O use_full_user_queue \
        --user-queue "kfd,pid=$pid,queue=$queue" \
        --dump-uq \
        >"$OUT/pid-${pid}-sdma-queue-${queue}.log"
done
