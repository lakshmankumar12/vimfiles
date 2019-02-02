# Normal key functions

[set ignorecase before searching!]

This is a list of keys and the commands they do in vim.
Vim's key-scape is pretty packed - Hardly any room to map to my personal commands.
So, here is a listing of the keys to commands to identify the gaps, that I can reclaim for my own maps.

```
q - recording (also useful q:,q/)                Q - ex mode. RECLAIM!                  (Bound to :tabclose)
w - word next                                    W - Blank-sep word forward
e - word end                                     E - Blank-sep word end
r - remove char                                  R - Remove multi chars
t - just before char (mnemonic : till)           T - backward-t
y - yank                                         Y - linewise yank(but same as yy). Useful if nmaped to y$
u - undo                                         U - undo changes on a line
i - insert                                       I - append at start of line
o - insert next line                             O - append at prev line
p - paste                                        P - paste before char
a - append                                       A - append at end of line
s - substitute  -- RECLAIM!                      S - RECLAIM!                        (bound s/S to easy-motion)
d - delete                                       D - delete till end of line
f - find char                                    F - backward-f
g - go                                           G - end of file
h - left                                         H - top of window
j - down                                         J - join lines
k - up                                           K - man page
l - right                                        L - end of window
z - fold                                         Z - RECLAIM!                       (bound to goto window n)
x - del                                          X - backspace
c - change                                       C - change till end of line
v - visual                                       V - line visual
b - word-back                                    B - blank-sep word backwardn
n - find-next                                    N - search back
m - mark                                         M - Middle of page
```

```
` - goto mark with column precision
~ - toggle case
1-9 - repeat count
0 - beg of line
! - not sure (RECLAIM?)
@ - recordplay
# - search back
$ - end of line
% - match brace
^ - beg of non-white char of line
& - repeat last substitue (:s command)
* - search backwards
( - para begin
) - para end
{} - block navigation
[] - diff navigation     (leveraged by git-gutter in normal-mode too!)
-  forward line  RECLAIM  (Bound to :cprev)
+  backward line RECLAIM  (Bound to :cnext)
= - indent
: repeat F/T
; repeat f/t
' goto mark to beg of line
" to select register for yank/paste
, RECLAIM  (same as ; but in opp direction)
. repeast last action
| goto column
\ Leader
/ search
? search backwards
```

g is a super powerful key: (gem key, literally!)

```
ga  - show hex of char under cursor
gd  - goto local declaration of word                               gD   --  global delcartion
ge - got to end of prev word                                       gE   --  prev Non-blank word
gf - open file under cursor                                        gF   --  file:line num works
gg - begining of file
gi - insert at previous insertation stop point                     gI   -- At column 1 (I will be first non-blank)
gj - go down on screen line                                        gJ   -- like J, but no space
gk - go up on screen line
gm - half g0                                                       gM   -- call MakePlainArayaka
gn - next and visual the word                                      gN   -- backward gn
go - got to nth byte in buffer
gp - like p, but leave cursor after pasted text                    gP   -- like P/gp, but P'ed effect  (Reclaimed to paste from clipboard+)
gq - Format visually chosen text.
gr - virtual replace (like screen estate useful on file with tabs) gR   -- virt-replace mode
gs - sleep
gt - next tab                                                      gT   -- prev tab
gu - lower case text                                               gU   -- upper-case text
gv - repeat previous virtual selection
g0 - screen beg line
g_ - last char. VERY USEFUL. Removes the annoying newline selection when doing $
g~ - toggle case (of motion)
g#/g* - like #/*, but no \<..\>
g$ - screen-end
g% - % backwards
g^ - first non-blank in screen
g& - repeat last subtittue
g] - show tags under cursor
g; - goto position in change list
g, - goto position in change list rev order
```


## RECLAIMable in g:

```
gb - some netrw bookmark            (copy to system cliboard)
gc - none                           (Tmux paste at new line) (gC is for paste wherever you are)
gh - enter select mode              (Rebound to unitish operations)
  ghb                             buffer
  gho                             buffer file file_mru
  ghO                             buffer file file_rec file_mru
  gh/                             line
  ghy                             history/yank
  ghd                             easy-clip d
  ghD                             easy-clip dd
gl - none                           (Bound to FZF)
  gll                             FZF (files in the curr folder)
  gloo                            AryakaFileOpen (git ls files)
  glb                             buffers
  gl/                             BufferLines
gw - format motion.
   gwa                              ( Bound to control-b <page-up> )
   gwb                              Show SVN Curr Diff
   gwc                              ( close window)
   gwd                              diffoff
   gwe                              (NerdTreeFind)
   gwf                              ( Bound to control-f <page-down> )
   gwg                              (Bound to gitGuttter disable)
   gwh                              ( gw h,j,k,l -> window movements)
   gwi
        gwii                        Open up a grep commandline
        gwir                               --do--              fill with rse
   gwj                              ( gw h,j,k,l -> window movements)
   gwk                              ( gw h,j,k,l -> window movements)
   gwl                              ( gw h,j,k,l -> window movements)
   gwm                              ( Bound to windcmd-p )
   gwn                              Bound to number/rel-number toggle
   gwo                              (Bound to Zoomwin)
   gwp                              DumpFullPathToClipBoard
   gwq                              DumpFullPathToTmuxClipBoard
   gwr                              (set wrap toggle)
   gws                              (set to horizontal window split)     # remember and use this
   gwt                              (New tab)                            # remember and use this
   gwu                              (DumpTagToTmuxClip)
   gwv                              (set to vertical window split)       # remember and use this
   gww                              (Bound to :update)
   gwx                              (tabclose w/o prev tab)
   gwy                              Duplicate buffer in new scratch tab
   gwz                              (set list toggle)

   gwB                              (setlocal noexpandtab)
   gwH                              ( gw H,J,K,L -> window close operations)
   gwJ                              --do--
   gwK                              --do--
   gwL                              --do--
   gwP                              ( plus/minus - vert resize +10 )
   gwM                              ( plus/minus - vert resize -10 )
   gwO                              :lclose
   gwN                              Bound to :qfixtoggle (MyFixLocFixWrapper)
   gwS                              (set spell toggle)
   gwT                              (new terminal)
   gwV                              vsplit and come back to same window
   gwX                              (syntax sync from start)
gx - netrw stuff                    (Bound to cscope operations)
gy
   gyy                              (Bound to set pastetoggle)
   gyo                              Open preview
   gyx                              Close preview
   gyp                              Plus/Increase preview size
   gym                              Minus/Decrease preview size
   gyu                              Up Scroll Preview
   gyd                              Down scroll preview

   gya                              AddACurrentPosition
   gyl                              LoadCurrPositions
   gyg                              LoadAndGotoLocations
   gye                              EditCurrPositions
   gyr                              ReplaceACurrentPosition
   gys                              GotoCurrentLocationListItem
   gyz                              ZapCurrentPosition

   gyt                              Open Toc


gz - none                           (Bound to solarized toggle bg)

gA                         (Free)
gB                         (Bound to FzfBuffers)
gC                         (Paste from tmux buffer)
gG                         (Bound to tags_*)
  gGG                                tags_f
  gGS                                tags_s
  gGT                                tags_s (typedef or struct)
  gGM                                tags_m
  gGV                                tags_v
  gGD                                tags_d
  gGE                                tags_e (defines or enum)
gH                         (Bound to :lprev)
gK
gL                         (Bound to :lnext)
gMA                        make-arayka acemon
gMM                        (Bound to last-tab)
gMR                        make-arayka rse
gMT                        :setlocal expandtab
gMX                        make-arayka ask
gO                         :Addressbar
gP                         (clip-board paste)
gS                         (Bound to MoveToDefintionOfMember)
gV  -- select-mode stuff.  (Bound to ToggleMouse)
gW                         (Bound to RemoveTrailWhite) # remove trail white space
gX                         (Flush Search)
gY                         (Bound to Keep window with only location-list)
```

## z-keys

```
za - toggles  a fold (Similar: zc/zo/za)                                  zA  - za at all folding levels
zb - bring line to bottom
zc - close a fold (in an existing fold(determined by mode))               zC  - zc at all folding levels
zd - delete one fold on cursor (in manual-fold mode)
ze - bring current column to end of screen
zf - create a fold (in manual-fold mode)                                  zF  - open my fav files
zg - open current work to good work (spell file) (RECLAIM)
zh - move view one step right                                             zH  - scroll left by half-screen
zi - Invert foldenable
zj - goto next fold down                                                  zJ  - all my jira maps (see below)
zk - goto end of previous fold
zl - move view one step step                                              zL  - scroll right by half-screen
zm - adds one fold level thru whole buff(inverse of zr)                   zM  - closes all folds in file
zn - fold none (reset foldenable)                                         zN  - set foldenable
zo - open fold under curor (in an existing fold)/complement of zc         zO  - zo at all folding levels
zp - NONE                       (Bound to :copen)
zr - reduces folding by opening one foldeding level over whole buf        zR  - open all folds
zs - bring current column to start of screen
zt - ..?..
zu - word-lists sth
zv -  open enuf folds to see line
z0 -
z~ -
z#/g*
z$ -
z% -
z^ -
z& -
z] -
```

## control keys:

```
C-a : increment
C-b : screen-back
C-c : abort
C-d : screen-down
C-e : scroll-lines downwards
C-f : screen-down
C-g : info on current-file
C-h : None.. RECLAIM
C-i : new position in jump list
C-j : lines downwards . RECLAIM
C-k : enter digraph
C-l : refresh screen
C-m - line downward .. non-white RECLAIM      (Dont mess .. bulbs entering in command-^f prompt)
C-n : lines downwards . RECLAIM               (NerdTreeToggle)
C-o : jump older
C-p : RECLAIM
C-q : visual block (esp in windows)
C-r : Redo
C-s : None
C-t : tag pop
C-u : scroll up
C-v : visual block
C-w : windows
C-x : decrement
C-y : scroll-lines upwards
C-z : suspend vim
```

## Insert mode control keys

```
c-a : repeat previous insertion
c-b : none
c-c : exit insert mode
c-d : del one shift-width indent
c-e : insert char from below-line
c-f : some indentation thing
c-g : navigation (follow with jk)
c-h : backspace
c-i : insert tab(or spaces)
c-j : newline
c-k : enter-digraph
c-l : go to normal mode
c-m : newline
c-n : next-match-word (auto-complete)
c-o : execute one command and come back
c-p : next-match-work (auto-complete)
c-q : same as c-v, enter sth literally
c-r : paste register
c-s : nothing
c-t : indent one sw
c-u : del all chars in a line
c-v : enter sth literally
c-w : del word
c-x : control-x submode
c-y : insert char from above-live
c-z : suspend vim
```

## Visual mode control keys

* help v_ctrl-a

```
c-a : increment number
c-b : To map to tmux copy
c-c :
c-d :
c-e :
c-f :
c-g :
c-h :
c-i :
c-j :
c-k :
c-l :
c-m :
c-n :
c-o :
c-p :
c-q :
c-r :
c-s :
c-t :
c-u :
c-v :
c-w :
c-x : decrement keys
c-y :
c-z :
```

## Window mgmt keys C-w, then

```
C-a : none
C-b : go to bottom most window
C-c : plain-c closes. Ctrl-c cancels
C-d : Open new window with macro on curosr
C-e : nothing
C-f : like gf, but in a split window!
C-g : nothing
C-h : left
C-i : open new window with same file, ANd bring cursor to first appearance of cur-word
C-j : down
C-k : up
C-l : right
C-m : nothing
C-n : new window
C-o : only
C-p : prev window
C-q : quit current window. Dont type! quits vim
C-r : rotate window (R rever dir) (Useful to exchange and stay in curr file)
C-s : split current to two horizonltally
C-t : top
C-u : nothing
C-v : split current to two vertically
C-w : without count, below-right, with count, goto nth window
C-x : exchange and come to other file.
C-y : nothing
C-z : close preview (not quickfix!)
C-] : split window on defintiion of cur-word
C-^ : new window on prev-buffer
C-_ : zoom window horizontally (unfortunatey can't restore that easily. Try =)
C-| : zoom window vertically (unfortunatey can't restore that easily. Try =)
+/-/</>/= : resize
H   : MOVE curr-window far left
J   : bot
K   : up
L   : right
P   : goto preview(not quickfix)
T   : move window to a new tab
}   : tag under cursor in preview
```

## Alt-combinations


```
      |        Normal            |  Insert
M-r   |      repl with term      |  --
M-s   |      new split term      |  <same-normal>
M-t   |      new vsplit term     |  <same-normal>
M-h   |      go tab left         |  <same-normal>
M-l   |      go tab right        |  <same-normal>
```


## Command-mode

* :help c_ctrl-a

```
C-a  :  all names to the left of pattern are inserted (Like auto tab-completion)
C-b  :  goto beginning of line
C-c  :  quit command line w/o executing
C-d  :  List names that match the pattern in front of the cursor. (like ? in our cli prompt)
C-e  :  goto end of line
C-f  :  open the command-line window
C-g  :  Nothing. RECLAIM
C-h  :  backspace
C-i  :  insert first match (tab-completion)
C-j  :  Enter (execute command)
C-k  :  digraph
c-l  :  Insert longest common (tab-completion)
C-m  :  Nothing. RECLAIM
C-l
C-m
C-n
C-o
C-p
C-q
C-r
C-s
C-t
C-u
C-v
C-w
C-x
C-y
C-z
C-]
C-^
C-_
C-|
```

# All My Leader maps

One char

```
nmap <Leader>b :BuffergatorOpen
nmap <Leader>B :BuffergatorClose
nmap <Leader>t :BuffergatorTabsOpen
nmap <Leader>T :BuffergatorTabsClose
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap <Leader>w <Plug>(easymotion-bd-w)
vmap <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>W <Plug>(easymotion-bd-W)
vmap <Leader>W <Plug>(easymotion-bd-W)
nmap <Leader>s <Plug>(SneakStreak)
nmap <Leader>S <Plug>(SneakStreakBackward)

nmap <Leader>1 .. 9  goto window N (gwN)
```
Multi-char

## Jira maps


```
nmap zJff  JiraRefresh          " You are in jira-op file. Download jira-op and refresh file
nmap zJss  OpenJira             " Get jira under curson in a scratch
nmap zJas  AskAndOpenJira       " Ask and open jira in scratch
nmap zJaf  AskAndOpenJiraOpFile " You are in Folder. Ask jira-num, download jira-o and open.
nmap zJll  RefreshJiraList      " Update the jira-list
```

## Fav file maps

```
nmap zFjj  open ~/tmp/jira_comment
nmap zFcc  open ~/tmp/commit_comment
nmap zFrr  open ~/tmp/review_description
```



## Leader maps from plugins

## Org mode

```
<Leader>cl/CL   # list item
<Leader>cn/CN   # check box
<Leader>cc      # toggle check box
```

## Highlight Different colors

```
<Leader>r
```

## rtags

```
<Leader>rj   - go-to-definition in same window
<Leader>rV   - go-to-definition in new vert split
<Leader>rS   - go-to-definition in new hor split
<Leader>rf   - open all references in location-win
<Leader>rb   - jump back


<Leader>ri   - Information on the word
<Leader>rJ   - Jump to declaration.
<Leader>rT   - new tab
<Leader>rp   - covering function, class
<Leader>rn   - Find symbol(s) references that match the provided pattern.
<Leader>rs   - Find declaration/definition location for symbol(s) that match provided pattern.
<Leader>rr   - Trigger current file reindexing by 'rdm'.
<Leader>rw      Rename symbol under cursor.
<Leader>rv      Find other implementations of a function, such as virtual functions.
<Leader>rC      Find the superclasses of the class under the cursor.
<Leader>rc      Find the subclasses of the class under the cursor.
```

## Enable auto-completion

```
call deoplete#enable()
```


## QFGrep:

```
(In quickfix/location-lsit)
<Leader>g  - grep and show matches
<Leader>v  - grep and show non-matches
<Leader>q  - reset
```

## Words

Really using:

```
map <Leader>mai i#include<stdio.h><CR><CR>int main(int argc,char *argv[],char *envp[])<CR>{<CR><CR>}<CR><Esc>kka<Tab>
map <Leader>cmai i#include<iostream><CR><CR>using namespace std;<CR><CR>int..n(int argc,char *argv[],char *envp[])<CR>{<CR><CR>return 0;<CR>}<CR><Esc>kka<Tab>
map <Leader>pyth i#!/usr/bin/python<CR><CR>from __future__ import print_fun..<CR><CR>def main():<CR>pass<CR><C-D><CR>if __name__ == '__main__':<CR>main()<CR>~
map <Leader>tail 100A <Esc>A;<Esc>h
map <Leader>clip :call DumpToClipBoard()<CR>
nmap <Leader>name        <Esc>:echo expand("%:p")<CR>
nmap <Leader>mshed       <Esc>:call ShedM()<CR>
nmap <Leader>css         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"s")<CR>
nmap <Leader>csg         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"g")<CR>
nmap <Leader>csc         <Esc>:call LoadCscopeToQuickFix(expand("<cword>"),"c")<CR>
nnoremap <Leader>gdb  <Esc>:Gdiff base<CR>gg<Esc>:wincmd l<CR>
```

Not that much:

```
nmap <Leader>cmd         <Esc>:call GetCommandOutputOnNewTab()<CR>
map <Leader>typ itypedef struct<CR>{<CR><CR>}  ;<Esc>hi
nmap <Leader>adds        <Esc>:call Addspaces()<CR>
nnoremap <Leader>pd   <Esc>:wincmd P<CR><C-D>:wincmd p<CR>
nnoremap <Leader>pu   <Esc>:wincmd P<CR><C-U>:wincmd p<CR>
nmap <Leader>ln   <C-w>h<Esc>:q<CR><C-w>P<C-n>
nmap <Leader>lp   <C-w>h<Esc>:q<CR><C-w>P<C-p>
nmap <Leader>hn   :q<CR><C-w>P<C-n>
nmap <Leader>hp   :q<CR><C-w>P<C-p>
nmap <Leader>gfunc    <Esc>:call FindFunctionFromTags()<CR>
```

# Cscope

the direct invocation is        :     `gx`         ,and the cscope-char
Quickfix invocation is          :     `<Leader>cs` ,and the cscope-char
                                         (remember \css, \csg, \csc rarely will use reset)

## tags

:Tagbar

# Navigation in vim

w - beginning of next word
b - beginning of current/prev word
e - end of current/next word
ge - end of prev word


# Vim text object selectors

Standard from vim:
```
iw  aw
i"  a"
i'  a'
i(  a(  ib/ab is a short-hand for parenthesis
i{  a{
i[  a[
it  at   between tag.
```

indent-plugin:
```
ii -> select lines with same indentation as current-line including encompassed lines with more indentation
iI -> select lines with EXACTLY same indendation as current-line.
```

line-plugin
```
il
```

text-between
```
if      Hrmph.. conflicts with python
```

python:
```
im  (edited from if so that it works)
ic

(also) [pf / ]pf - next/prev function
(also) [pc / ]pc - next/prev class
(also) [-  /     - up an indent (from indentwise plugin)
```

# surround

```
ds" ds' ds( ds[  ds{
cs"'
ys<motion><sur-char>
```

select visually, press S and then the surround char ",'
note: if you press opening-brace, there will be a space added. if you use closing-brace, no space is added

# Search modifiers

```
\c<pattern> will ignore case
<pattern>/e will place cursor at end of pattern
         /s will place curros at start of pattern (needed when combining number below) .. use s5 to place cursor at 5th char.
         /<num>  will goto line-above (or chars if e/s is used). This is 0-based counting. 1 will be next char. 0 is redundant to mention
         /-num     --do--      -below ( --do-- )
```

:help search-offset

# Paste just the matched pattern

Search terms: search, register, paste

Remember/Mnemonic: c-r as usual for command mode, c-x for insert, Its shift-7 always.

```
in insert-mode
c-x &

in command-line
c-r &
```

# Quickly grep in a given file

```
" Opens the lines with patter in location list
:lvimgrep /pattern/ %
```

## non-gredy grep

Instead of .* use .\{-}.

## grep IP

```
\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}
```

# Other Vim Tips:

In a huge list of cscope-s results on a function-name, to quickly find the function defintion, try

```
function_name\s*(\s*\w\+\s\+\w.*,
\w\+\s*(\s*\w\+\s\+\w.*,
```

i.e name space* ( space* word+ space+ word+ .* ,
    The idea is only definition will have 2 words min between ( and , arg-type and arg-name, while invocations will have just argname.
    The -> and . will separate words in invocations too, but hopefully they dont have space inbetween!


:set hidden  # option enables the non-saving of files while switching (unnecessary swap files)
echo &hidden # is a way to see the current setting.

## Colors in vim:

* Its either cterm or gui.
* cterm colors are either words or nubmers from 0 to 255. To know colors use the plugin :XtermColorTable
* gui colors are either words or RGB spec

* Soloarized sticks to the first 16 colors.

```
ctermbg=red ctermfg=white
guibg=#8CCBEA guifg=Black
```


## To know which plugin set the setting last

```
:verbose set iskeyword?
```

## Set vertical scrollbind in 2 splits

```
:windo setlocal scrollbind
ctrl-W <size> |   " to fix the vertical size
```

To not jump to start of line on scrolling
```
:set nosol
```

## Diff

If diff gets wonky, do
:diffupdate
--or--
:bufdo diffoff
and diff again.

## Navigating based on indent (for config files)

(Effected by plugin vim-indentwise)

:set foldmethod=indent
]= / [=  -- next/prev lines on same indentation level
[-       -- prev .. go one level up

## Fold Management

```
zR/zM  -> open-all-folds/close-all-folds
zo/zc  -> open/close jsut one fold
zr/zm  -> open/close fold level by one
zO     -> open all folds in cursor recursively

zj/zk  -> up/down to prev/next fold
[z/]z  -> start/end of current fold
```

*# Org mode

end files in .org

```
* Heading 1
** Heading 2
   - List item   (<leader>cl/cL)
   - [ ] Check bo (<leader>cn/cN)  (toggle status <leader>cc)
```

## Multiple Highlight

```
\m             to highlight current word
\r             to get prompt and enter regex
:MarkClear     to reset everything
\*,\#          to go to the next occurence of last mark. If you do this on a marked word,
               that becomes the last mark.
\/,\?          to any mark
               (Mnemonic: * and # are complements, / and ? are complements. * is for narrower/sharper search)
```

## Denite/Unite movement

```
ctrl-o to enter normal mode
i to come back to insert
```


## Spell check

```
(I have mapped gwS)

:set spell
]s next misspelled word
[s prev misspelled word
```

## Sort a file

```
:%sort
:'<,'>sort

#only uniq
:sort -u
```

## Reverse lines

```
"full file
:g/^/m0   " g is to take action on lines matching ensuing regex, ^ matches every line, m move, 0 -> after line-0

"part of file
:'<,'>g/^/mN  " rember to get N (line number before selection)

"fully with line numbers
:100,150g/^/m99
```

## Mark and save a subset to another file

```
mA
mB
then
:'A,'B w! /tmp/a
```

## Set a column limit to files

```
:set colorcolumn=80
```

## Working on Columns

column-replace:

Select a column/block using ctrl-v, and then press: and then type `<space> B s/find/repl/g`, it will replace on the column.

## Tabularize around a char

```
:Tabularize /|
```

## Delete empty lines

```
#choose line that is empty or anti-choose line with atleat one char
:g/^$/d
:v/./d

#choose line that is having only space or anti-choose line that has one-non-space char
:g/^\s*$/d
:v/\S/d
```

## NerdTree

NerdTreeToggle  (mapped to C-n. Just opens nerd-tree at cwd)
NerdTreeFind    (opens Nerdtree at file location)

```
Enter -> at a folder opens up the folder
x     -> close current parent
p     -> go to parent
?     -> close in case you accidentally opened help with ?
R     -> refresh
```

## NERDCommenter

```
<leader>cc  -> comment
```

## My SVN plug

```
:SVNDiff          gwb     " with a file .. will diff the current changes
:SVNAnno                  " with a file .. will annotate the file
:SVNRev                   " in annotate window (or on a revision word) .. will get the rev on a window
:SVNShowRev               " Anywhere .. asks a revision number and shows it..
:SVNRDiff                 " in a rev-window on a file .. shows the changes of that one file
:SVNStatus                " Anywhere .. shows the svn status
:SVNLog                   " Anywhere .. shows the last 10 logs (or n as arg)"
```

## fugitive notes

```
* Do any fugitive command by first opening a source controlled file in vim
* O -> open commit
  P -> annotate parent
* If you have opened a commit or a file, do a y^g to yank the current commit into clipboard
```

## jedi-vim

```
#python jumpter

<Leader> d   - goto definition
<Leader> gu   - goto all usages
^t (gxx)     - goback
```


## Expansion

```
:help expand
%    current file name
#    alternate file name
#n    alternate file name n
<cfile>    file name under the cursor
<afile>    autocmd file name
<abuf>    autocmd buffer number (as a String!)
<amatch>  autocmd matched name
<sfile>    sourced script file name
<slnum>    sourced script file line number
<cword>    word under the cursor
<cWORD>    WORD under the cursor
<client>  the {clientid} of the last received
message |server2client()|
Modifiers:
:p    expand to full path
:h    head (last path component removed)
:t    tail (last path component only)
:r    root (one extension removed)
:e    extension only

eg:
expand("<cWORD>")
```


## My git-ls files

```
:Gedited  -> Show all edited files

This works by loading modified files (or interest files) using vim's make by temporarily tying git diff --name-only as make program.
So, if u want the list of all files, just use :lopen.
You can skip to any file of interest. Just 
gwo
:bufdo diffoff
and <Leader>gg to diff the file
```

General diff 2 files

```
<Leader>go  -- diff off
<Leader>gd  -- diff 2 wins
```

# vimscript

* See lang-notes

# Sparkling vim features to brag with others

* Selection can go back and forth -  if you didn't start at the right point.
* Selection can select objects wherever you are (word, within brace/quote/any-char, line)

# Snippets

Read about them here - http://vimcasts.org/episodes/meet-ultisnips/
Look for snippets in - https://github.com/honza/vim-snippets -> UltiSnips

```
<tab>  - expand trigger
<C-j>  - advance to next tabstop
<C-k>  - reverse to previous tabstop
```

### Useful snippets:

* markdown
    ```
    cbl<tab>   - for code blocks
    ```

* python
    * ifmain
    * if
    * for
    * with
    * class
    * argp

# Syntax highlighting in vim

To Read: http://vim.wikia.com/wiki/Creating_your_own_syntax_files
https://jordanelver.co.uk/blog/2015/05/27/working-with-vim-colorschemes/

High level objects
* syntax-keyword -  categorizes a bunch of text matching some rule as a particular syntax-group
```
syntax match <SYN-KEY-NAME> <expression-to-match>
```
* Highlight Group - defines a color-pattern
* Link a syntax-keyword to a highlighting groups
```
hightlight link <SYN-KEY-NAME> <HIGHLIGHTGROUP>
```

* Checkout existing hightlight groups with `:highlight`

## Fix a broken syntax highlighting

I have mapped this to gwX
```
syntax sync fromstart
```

# Add a digraph to vim


