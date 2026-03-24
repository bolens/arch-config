# keychain SSH agent setup
if status is-interactive
    keychain --eval --quiet michael@bolens | source
    keychain --eval --quiet bolens@duck | source
end
