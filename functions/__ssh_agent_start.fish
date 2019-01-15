function __ssh_agent_start -d "start a new ssh agent"
    if test -f "$SSH_ENV"
        source $SSH_ENV
    end
    if not set -q SSH_AGENT_PID
        or not ps --no-headers -q $SSH_AGENT_PID >/dev/null
        set -eU SSH_AGENT_PID
        set -eg SSH_AGENT_PID
        set -eU SSH_AUTH_SOCK
        set -eg SSH_AUTH_SOCK

        ssh-agent -c | sed 's/^echo/#echo/' | sed 's/^setenv/set -xg/g' >$SSH_ENV
        chmod 600 $SSH_ENV
        source $SSH_ENV >/dev/null
        ssh-add >/dev/null 2>/dev/null
    end
end