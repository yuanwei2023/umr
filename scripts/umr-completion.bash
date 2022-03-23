# bash completion for umr

_setup()
{
    select_gpu=""
    if [ $COMP_CWORD -ge 4 ]; then
        for i in ${!COMP_WORDS[@]}; do
            if [[ ${COMP_WORDS[$i]} = "--gpu" ]] ||
                [[ ${COMP_WORDS[$i]} = "-g" ]] ||
                [[ ${COMP_WORDS[$i]} = "--instance" ]] ||
                [[ ${COMP_WORDS[$i]} = "-i" ]]; then
                select_gpu=${COMP_WORDS[$i]}" "${COMP_WORDS[$i+1]}
                break
            fi
        done
    fi

    ips=( $( sudo $(which umr) $select_gpu -lb ) )
    asicname=${ips%%.*}
    unset ip_names
    for ip in ${ips[@]}
    do
        ipname=${ip#*.}
        ip_names+=($ipname)
    done
}

_comp_blocks()
{
    _setup

    if [ -z "$cur" ]; then
        COMPREPLY=( $(compgen -W "${ips[*]}" -- "$cur") )
    fi

    if [ -n "$cur" ]; then
        local array=( "${ips[@]}" "${ip_names[@]}" "${ip_names[@]/#/*.}" )
        COMPREPLY=( $(compgen -W "${array[*]}" -- "$cur") )
    fi
}

_comp_regs()
{
    _setup

    if [[ "$cur" =~ ^[^.]*'.'[^.]*'.'[^.]*$ ]]; then
        cur_asic="${cur%%.*}"
        substr="${cur#*.}"
        cur_ip="${substr%.*}"
        if [[ "${ip_names[@]}" =~ "$cur_ip" ]] && [[ $cur_asic = $asicname || $cur_asic = "*" ]]; then
            reg_names=( $(sudo $(which umr) $select_gpu -lr $asicname.$cur_ip | grep -o "$asicname\.$cur_ip\.\w\+") )
            COMPREPLY=( $(compgen -W "${reg_names[*]/$asicname/$cur_asic}" -- "$cur") )
        fi
    elif [ -n "$cur" ]; then
        local array=( "${ips[@]}" "${ip_names[@]/#/*.}" )
        COMPREPLY=( $(compgen -W "${array[*]/%/.}" -- "$cur") )
        compopt -o nospace
    else
        COMPREPLY=( $(compgen -W "${ips[*]/%/.}" -- "$cur") )
    fi
}

_umr_completion()
{
    local cur prev 

    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    case $prev in
        -lr|--list-regs|-s|--scan)
            _comp_blocks
            return 0
            ;;
        -r|--read|-w|--write)
            _comp_regs
            return 0
            ;;
    esac
}

complete -F _umr_completion umr
