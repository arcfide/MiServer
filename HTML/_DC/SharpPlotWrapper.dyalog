:Class SharpPlotWrapper  : #._html.div
⍝ Description:: Wraps a SharpPlot instance (from SharpPlotInit)
⍝ Constructor:: SharpPlotInstance

    :field public shared readonly APILevel←2
    :field public Causeway
    :field public System
    :field public sp

    ∇ make1 arg
      :Access Public
      :Implements Constructor
      'SharpPlotWrapper constructor argument must be an SharpPlot instance'⎕SIGNAL 11/⍨∨/'Causeway.SharpPlot'⍷⊃⊃⎕CLASS arg
      sp←arg
      :Trap 6
          System.Drawing←System←Causeway←#.Causeway
      :Else
          'SharpPlot not initialized'
      :EndTrap
    ∇

    ∇ r←Render
      :Access Public
      Content←sp.RenderSvg Causeway.SvgMode.FixedAspect
      r←⎕BASE.Render
    ∇

:EndClass
