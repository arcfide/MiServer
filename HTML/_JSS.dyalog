﻿:Namespace _JSS ⍝ Javascript Snippets

    ⍝∇:require =\JSON
    (⎕ML ⎕IO)←1
⍝ this list will grow over time as usage patterns are discovered
    eis←{(,∘⊂)⍣((326∊⎕DR ⍵)<2>|≡⍵),⍵} ⍝ Enclose if simple
    enlist←{∊⍵}
    quote←{'"'∊⍵:⍵ ⋄ '"',(⍕⍵),'"'}
    ine←{0∊⍴⍺:'' ⋄ ⍵} ⍝ if not empty
    fmtSelector←{{'this'≡⍵:⍵ ⋄quote ⍵}¯2↓enlist{⍵,', '}¨eis ⍵}
    fmtData←{0=2|⎕DR ⍵:quote ⍵ ⋄ ⍕⍵}
    JAchars←#.JSON.JAchars

    ∇ r←Alert txt
      r←'alert(',(quote txt),');'
    ∇

    ∇ r←{val}(sel JQuery fn)args;opt
    ⍝ construct JavaScript to call a jQuery function - eg val(), html(), css(), or attr()
    ⍝ optionally setting a value for
    ⍝ Get a jQuery parameter:
    ⍝    ('"#id"' JQuery 'attr') '"data-role"'
    ⍝ Set a jQuery parameter:
    ⍝    '"blue"' ('#id' JQuery 'css') 'background-color'
    ⍝
      args←eis args
      :If 0=⎕NC'val'
          (opt val)←2↑args,(⍴args)↓''⎕NULL
      :Else
          opt←⊃args
      :EndIf
      :If val≡⎕NULL
          r←'$(',(fmtSelector sel),').',fn,'(',(quote opt),');'
      :Else
          r←'$(',(fmtSelector sel),').',fn,'(',(quote opt),',',(fmtData val),');'
      :EndIf
    ∇

    ∇ r←{val}(fn JQueryOpt sel)opt
      :If 0=⎕NC'val'
          r←'$(',(fmtSelector sel),').',fn,'("option",',(quote opt),');'
      :Else
          r←'$(',(fmtSelector sel),').',fn,'("option",',(quote opt),',',(fmtData val),');'
      :EndIf
    ∇

    ∇ r←sel Css args ⍝ JQuery css cover
      r←(sel JQuery'css')args
    ∇

    ∇ r←sel Val args ⍝ JQuery val cover
      r←(sel JQuery'val')args
    ∇

    ∇ r←sel Attr args ⍝ JQuery attr cover
      r←(sel JQuery'attr')args
    ∇

    ∇ r←sel Html args ⍝ JQuery html cover
      r←(sel JQuery'html')args
    ∇

:EndNamespace