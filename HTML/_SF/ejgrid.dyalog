﻿:class ejGrid : #._SF._ejWidget
    :Field public shared readonly ApiLink←'http://help.syncfusion.com/UG/JS_CR/ejGrid.html'
    :Field public shared readonly ApiLevel←3

    :Field Public Values←0 0⍴⊂''
    :Field Public Columns←⍬      ⍝ Vector of namespaces using JSON names

    :Field Public ColNames←⍬     ⍝ JSON: field
    :Field Public ColTitles←⍬    ⍝       headerText
    :Field Public CellWidths←⍬   ⍝       width
    :Field Public CellFormats←⍬  ⍝       format
    :Field Public CellAlign←⍬    ⍝       textAlign

    script←{⎕NEW #._HTML.Script ⍵}
    ⍝ window.gridData=[{OrderID:10248,CustomerID:"VINET",EmployeeID:5,OrderDate:new Date(8364186e5),
    ⍝ShipName:"Vins et alcools Chevalier",ShipCity:"Reims",ShipAddress:"59 rue de l'Abbaye",
    ⍝ ShipRegion:null,ShipPostalCode:"51100",ShipCountry:"France",Freight:32.38,Verified:!0},...

    ∇ makec args;x;values;cols;widths
      :Access public
      args←eis args
      JQueryFn←Uses←'ejGrid'
      :Implements Constructor :Base args
      (x Values ColTitles CellWidths)←4↑args,(⍴args)↓''(0 0⍴⍬)⍬ ⍬
      :If 0≠⍴ColTitles
          :If 326=⎕DR⊃ColTitles ⋄ Columns←ColTitles ⋄ ColTitles←⍬
          :Else ⋄ ColNames←ColTitles~¨' '
          :EndIf
      :EndIf
    ∇

    ∇ r←Render;fields;src;rows;cols;coldefs;colfields;i
      :Access public 
      r←''
      (rows cols)←⍴Values
      :If 0=cols
          r←'[grid with zero columns]'
      :Else
          :If 0≠⍴Columns ⋄ coldefs←Columns ⋄ ColNames←Columns.field
          :Else ⍝ Put Columns together from individual properties
              coldefs←(cols,0)⍴⊂'' ⋄ colfields←⍬
              :If 0≠⍴ColNames ⋄ coldefs,←ColNames ⋄ colfields,←⊂'field' ⋄ :EndIf
              :If 0≠⍴ColTitles ⋄ coldefs,←ColTitles ⋄ colfields,←⊂'headerText' ⋄ :EndIf
              :If 0≠⍴,CellWidths ⋄ coldefs,←cols⍴CellWidths ⋄ colfields,←⊂'width' ⋄ :EndIf
              :If 0≠⍴CellFormats ⋄ coldefs,←CellFormats ⋄ colfields,←⊂'format' ⋄ :EndIf
              :If 0≠⍴CellAlign ⋄ coldefs,←CellAlign ⋄ colfields,←⊂'textAlign' ⋄ :EndIf
     
              coldefs←colfields #.JSON.formatData coldefs
              :If 0≠⍴CellFormats ⋄ :AndIf 0≠⍴i←(0=⊃∘⍴¨CellFormats)/⍳⍴CellFormats
                  coldefs[i].⎕EX⊂'format' ⍝ Remove empty formats
              :EndIf
          :EndIf
          coldefs←#.JSON.fromAPL coldefs
     
          'columns'Set'⍎',coldefs
     
          src←GenId
          'dataSource'Set'⍎',src
          r←(⎕NEW #._HTML.Script('var ',src,' = ',#.JSON.fromAPL ColNames #.JSON.formatData Values)).Render
      :EndIf
      r,←⎕BASE.Render
    ∇

    ∇ r←Refresh items;src;script;fields;ri;rI
      :Access public
      r←''
      items←eis items
      :If 0∊⍴src←GetOption'dataSource'
          r,←Selector Replace∊{'<li>',⍵,'</li>'}¨Items←items
          r,←Execute'$("',Selector,'").',JQueryFn,'({dataSource:',src,'});'
      :Else
          :If (1=ri←⍴⍴items)∧(2=rI←⍴⍴Items)
          :AndIf 1=2⊃⍴Items ⋄ ri←⍴⍴items←⍪items ⋄ :EndIf
          :If 2∧.=ri,rI
          :AndIf (2⊃⍴items)=2⊃⍴Items
              src←('⍎'=⊃src)↓src
              Items←(fields←Items[1;])⍪items
              r,←Selector Replace''
              script←';',src,' = ',#.JSON.fromAPL fields #.JSON.formatData 1↓Items
              script,←';$("',Selector,'").',JQueryFn,'({dataSource:',src,'});'
              r,←Execute script
          :EndIf
      :EndIf
    ∇

:EndClass