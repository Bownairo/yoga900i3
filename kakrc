set global termcmd "gnome-terminal -e"
#set global ycmd_path /home/eero/Build/ycmd/ycmd/

hook global WinSetOption filetype=c %{
    	#clang-enable-autocomplete
    	#clang-enable-diagnostics
    	#alias window complete clang-complete
        #map window insert <a-tab> <a-\;>b<a-\;>c<a-\;>:complete<ret><a-\;>p
        #hook window BufWritePost .* %{clang-parse}
        #map window user n :clang-diagnostics-next<ret>
        #ycmd-enable-autocomplete
}

hook global WinCreate .* %{
    addhl number_lines
}

set global scrolloff 3,5

set global tabstop 4
hook global InsertChar \t %{
    try %{
        exec -draft h@hW<a-\;>L<a-k>\A<space>+\Z<ret>d
    }
}

map global normal '#' :comment-line<ret>

#hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <backtab> <c-p> }
#hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <backtab> <c-p> }

map global insert <backspace> '<a-;>:insert-bs<ret>'

decl -hidden int minusone 3

def -hidden insert-bs %{
    try %{
        # delete indentwidth spaces before cursor
        exec -itersel -draft -no-hooks h %opt{minusone}H <a-k>\A<space>+\Z<ret> d
    } catch %{
        exec <backspace>
    }
}
