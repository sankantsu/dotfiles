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
eval "$(~/.local/bin/mise activate bash)"

# $HOME/bin (highest priority)
add_path "$HOME/bin"
