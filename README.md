## Description
Use the HLNext function to blink search matches for a certain period of time
with a certain frequency.

Remapping the n, N and * commands to a call to the the HLNext function in your `.vimrc` makes the
blinking feature transparent, for instance:

```
 let s:blink_length = 500
 let s:blink_freq = 50
 execute printf("nnoremap <silent> n n:call HLNext(%d, %d)<cr>", s:blink_length, s:blink_freq)
 execute printf("nnoremap <silent> N N:call HLNext(%d, %d)<cr>", s:blink_length, s:blink_freq)
 execute printf("nnoremap <silent> * *:call HLNext(%d, %d)<cr>", s:blink_length, s:blink_freq)
```

## Installation

Vim must have the timer feature addded in Vim8. Using Vim8's built-in package
manager, from `~.vim` do:

```
~/.vim$ git submodule add https://github.com/dakeryas/BlinkSearch.vim.git
```
