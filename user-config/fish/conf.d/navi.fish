# navi cheatsheet widget
# Ctrl+G is taken by ghq, so navi is mapped to Alt+N
if command -q navi
    navi widget fish | source
    # Override navi's default Ctrl+G binding with Alt+N
    bind \en _navi_smart_replace
    if bind -M insert >/dev/null 2>/dev/null
        bind -M insert \en _navi_smart_replace
    end
    # Remove the Ctrl+G binding navi sets (ghq owns it)
    bind -e \cg 2>/dev/null
    bind -M insert -e \cg 2>/dev/null
end
