:Class index :MiPageSample

    ∇ Render
      :Access public
      Add h3'Modified input element'
     ⍝ Return the value of the field fname when it changes and uppercase it
      (Add EditField 'fname').On 'change' 'capital' ('fname' 'val')
    ∇

    ∇ r←capital;V;UV;Exp
      :Access public
	V←Get'fname' 		⍝ retrieve the value associated with a name
	UV←#.Strings.uc V 	⍝ uppercase it
	Exp←'#fname' Val UV	⍝ turn it into JQuery (Javascript)
      r←Execute Exp	⍝ return as expression to execute in the browser
    ∇
:EndClass
