﻿:class ButtonSimple : MiPageSample
    
    ∇ Compose
      :Access public 
     
      Add'Here is a flat button: '
     ⍝ Create a button with no caption
      Add _.Button
     
      Add'This is very '
     ⍝ Create a button with a caption of 'clickable'
      Add _.Button'clickable!'
     
      Add'Click '
     ⍝ Create a button with a caption of 'this' and an id of 'myname'
      Add _.Button'this' 'myname'
      Add'to select nothing. '
     
      Add'Push '
     ⍝ Create a button with a caption of 'here' and an id of 'myname'
      Add _.Button'All' 'myname' 'somedata' ⍝ and a value of 'somedata'
      Add'my buttons. '
    ∇
    
:endclass