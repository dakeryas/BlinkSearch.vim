" Modified version of Damian Conway's Die Blinkënmatchen by Rich: highlight matches
"
 " let s:blink_length = 500

 " This is the length of each blink in milliseconds. If you just want an
 " interruptible non-blinking highlight, set this to match s:blink_length
 " by uncommenting the line below
 " let s:blink_freq = 50
 "let s:blink_freq = s:blink_length
 let s:blink_match_id = 0
 let s:blink_timer_id = 0
 let s:blink_stop_id = 0

 " Toggle the blink highlight. This is called many times repeatedly in order
 " to create the blinking effect.
 function! BlinkToggle(timer_id)
     if s:blink_match_id > 0
         " Clear highlight
         call BlinkClear()
     else
         " Set highlight
         let s:blink_match_id = matchadd('ErrorMsg', s:target_pat, 101)
         redraw
     endif
 endfunction

 " Remove the blink highlight
 function! BlinkClear()
     call matchdelete(s:blink_match_id)
     let s:blink_match_id = 0
     redraw
 endfunction

 " Stop blinking
 "
 " Cancels all the timers and removes the highlight if necessary.
 function! BlinkStop(timer_id)
     " Cancel timers
     if s:blink_timer_id > 0
         call timer_stop(s:blink_timer_id)
         let s:blink_timer_id = 0
     endif
     if s:blink_stop_id > 0
         call timer_stop(s:blink_stop_id)
         let s:blink_stop_id = 0
     endif
     " And clear blink highlight
     if s:blink_match_id > 0
         call BlinkClear()
     endif
 endfunction

 augroup die_blinkmatchen
     autocmd!
     autocmd CursorMoved * call BlinkStop(0)
     autocmd InsertEnter * call BlinkStop(0)
 augroup END

 function! HLNext(blink_length, blink_freq)
     let s:target_pat = '\c\%#'.@/
     " Reset any existing blinks
     call BlinkStop(0)
     " Start blinking. It is necessary to call this now so that the match is
     " highlighted initially (in case of large values of a:blink_freq)
     call BlinkToggle(0)
     " Set up blink timers.
     let s:blink_timer_id = timer_start(a:blink_freq, 'BlinkToggle', {'repeat': -1})
     let s:blink_stop_id = timer_start(a:blink_length, 'BlinkStop')
 endfunction
