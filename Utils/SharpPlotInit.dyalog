 r←SharpPlotInit
 :If 0=#.⎕NC'Causeway'
     'Causeway'#.⎕NS''
     #.Causeway.⎕CY'sharpplot'
 :EndIf
 'Could not find #.Causeway'⎕SIGNAL 11/⍨0=#.⎕NC'Causeway'
 System.Drawing←System←Causeway←#.Causeway
 r←⎕NEW Causeway.SharpPlot
