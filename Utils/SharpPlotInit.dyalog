 r←SharpPlotInit
 :If 'Win'≡3↑⊃#.⎕WG'APLVersion'
     ⎕USING←',sharpplot.dll' ',system.drawing.dll' ⍝ you probably want to localise ⎕USING
 :Else
     :If 0=⎕NC'Causeway' ⋄ (System.Drawing←System←⍎'Causeway'⎕NS'').(⎕CY'sharpplot') ⋄ :EndIf
 :EndIf
 r←⎕NEW Causeway.SharpPlot
