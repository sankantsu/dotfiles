add_path() {
    path_to_add="$1"

    case ":${PATH}:" in
        *:"${path_to_add}":*)
            ;;
        *)
            # Prepending path in case a system-installed deno executable needs to be overridden
            export PATH="${path_to_add}:$PATH"
            ;;
    esac
}

# mise
if [ -n "${ZSH_VERSION:-}" ]; then
    eval "$(~/.local/bin/mise activate zsh)"
else
    eval "$(~/.local/bin/mise activate bash)"
fi

# $HOME/bin (highest priority)
add_path "$HOME/bin"
