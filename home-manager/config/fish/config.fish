if status is-interactive
    # Commands to run in interactive sessions can go here
end


function fish_mode_prompt
end

set fish_greeting

any-nix-shell fish --info-right | source
