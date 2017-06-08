set global termcmd "gnome-terminal -e"
set global ycmd_path /home/eero/Build/ycmd/ycmd/

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

set global tabstop 4

map global normal '#' :comment-line<ret>

hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <backtab> <c-p> }
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <backtab> <c-p> }

