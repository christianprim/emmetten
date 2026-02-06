#import "@preview/touying:0.6.1"
#import "@preview/metalogo:1.2.0": LaTeX, TeX
#import "eth-theme.typ": *
#import "@preview/unify:0.7.1": qty
#import "@preview/codly:1.3.0": codly-init, codly
#import "@preview/codly-languages:0.1.10": *
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3"
#import "@preview/physica:0.9.8"

#show: codly-init.with()

#codly(languages: codly-languages)
#codly(zebra-fill: eth-theme-colors.primary.lighten(90%), header: [Code])

#show math.equation: set text(font: "Fira Math")

#set text(lang: "de", region: "CH")

#show: eth-theme.with(
  config-info(
    title: [Emmetten 2026 \ Typst im Unterricht],
    author: [Christian Prim],
    date: datetime.today(),
  ),
  config-common(
    datetime-format: "[day].[month].[year]")
  )

#let schreibpapier(height: none, size: 4mm) = context { 
  let grid_height = height
  if height != none {
    assert(type(height) == length, message: "Height muss eine Länge sein (z.B. 10pt)")
  } else {
    grid_height = 1fr
  }
  
  block(height: grid_height, layout(place => { 
    let columns = calc.floor(place.width / size)
    let rows = calc.floor(place.height / size)
  
    block({
      grid(
        columns: (size,) * columns,
        rows: (size,) * rows,
        stroke: aqua + .1pt,
      )
    })
  }))
}

#let brown = rgb("#a52a2a")

= Was ist Typst?

== Das neue Satzsystem Typst

*Typst* ist ein modernes, Open-Source-basiertes *Satzsystem*, das als schnellere und benutzerfreundlichere Alternative zu #LaTeX entwickelt wurde. Es wurde entworfen, um wissenschaftliches Schreiben und Dokumentendesign so effizient wie möglich zu gestalten.

== Was Typst auszeichnet

- *Einfachheit:* Es nutzt eine Markup-Syntax, die so intuitiv wie Markdown ist, aber die volle Kontrolle über das Layout bietet.
#pause

- *Performance:* Im Gegensatz zu #LaTeX kompiliert Typst praktisch so schnell wie der Text eingegeben wird (meist in Millisekunden). Jede Änderung im Code ist sofort in der Vorschau sichtbar.
#pause

- *Programmierbarkeit:* Es besitzt eine integrierte Skriptsprache mit logischen Funktionen (Variablen, Schleifen, Funktionen), was das Erstellen komplexer Layouts oder automatischer Formatierungen extrem erleichtert.
#pause

- *Modernes Paketmanagement:* Es gibt kein mühsames Installieren von Paketen wie bei #TeX Live; Typst verwaltet Abhängigkeiten automatisch und sauber.

== Ein kurzer Vergleich

#show table.cell.where(y: 0): set text(white)
#show table.cell.where(x: 0): set text(white)

#figure( 
  table(
    columns: 3,
    stroke: none,
    fill: (x, y) =>
    if x == 0 or y == 0 {
      eth-theme-colors.primary
    },
    inset: 1em,
    [], [#LaTeX], [Typst],
    [Lernkurve], [Steil (viele Sonderzeichen/Befehle)], [Flach (ähnlich wie Markdown)],
    [Geschwindigkeit], [Langsam (mehrere Durchläufe nötig)], [Extrem schnell (inkrementell)],
    [Fehlermeldungen], [Oft kryptisch], [Klar und präzise],
    [Installation], [Riesige Distributionen], [Eine einzelne, kleine Binärdatei]
  )
)

== Fazit

Typst ist für alle gedacht, die die professionelle Satzqualität von LaTeX benötigen, aber keine Lust auf die veraltete Syntax und die langen Wartezeiten beim Kompilieren haben.

Das spricht uns an, wenn es um unsere Arbeitsblätter und allenfalls Präsentationen geht.

Aber auch unsere Maturanden, die ihre Maturitätsarbeit gerne mit einem vernünftigen Programm schreiben wollen.

= Einige Beispiele

== Formelsatz

#grid(
  columns: (1fr, )*2,
  [
    $ arrow(F)_"res" = m arrow(a) $

    $m$ sei die Masse des Körpers

    $ T = 2 pi sqrt(l/g) $

    Display oben und normal unten

    $T = 2 pi sqrt(l/g)$
  ],
  [
    #pause
    #codly(header: [*Formelsatz*])
    ```typst
    $ arrow(F)_"res" = m arrow(a) $

    $m$ sei die Masse des Körpers

    $ T = 2 pi sqrt(l/g) $

    Display oben und normal unten

    $T = 2 pi sqrt(l/g)$
    ```
  ]
)

== Verweise

#grid(
  columns: (1fr, )*2,
  gutter: 1cm, 
  [
    #set math.equation(numbering: "(1)")

    Wellenfunktion:

    $ y(x, t) = hat(y) sin (2 pi (t/T - x/lambda)) $<wf>

    In @wf bedeutet $hat(y)$ die Amplitude der Welle.
  ],
  [
    #pause
    #codly(header: [*Verweise*])
    ```typst
    #set math.equation(numbering: "(1)")

    Wellenfunktion:

    $ y(x, t) = hat(y) sin (2 pi (t/T - x/lambda)) $<wf>

    In @wf bedeutet $hat(y)$ die Amplitude der Welle.
    ```
  ]
)

== Bilder

#grid(
  columns: (1fr, )*2,
  gutter: 1cm, 
  [
    #image("figs/bg_eth.jpg")
  ],
  [
    
    #codly(header: [*Bilder*])
    ```typst
    #image("figs/bg_eth.jpg")
    ```
  ]
)

== Eingebaute Funktionen mit Inhalt
#grid(
  columns: (1fr, )*2,
  gutter: 1cm, 
  [
    #text(fill: red, "Rot")
  ],
  [
    #codly(header: [*Inhalt als Argument*])
    ```typst
    #text(fill: red, "Rot")
    ```
  ]
)

#slide(
  grid(
    columns: (1fr, )*2,
    gutter: 1cm, 
    [
      #text(fill: red)[Rot]
    ],
    [
      
      #codly(header: [*Inhalt in []*])
      ```typst
      #text(fill: red)[Rot]
      ```
    ]
  )
)

#slide(
  grid(
    columns: (1fr, )*2,
    gutter: 1cm, 
    [
      #block({
        set text(fill: red)
        [Rot]
      })
    ],
    [
      
      #codly(header: [*Allgemeine Einstellung*])
      ```typst
      #set text(fill: red)
      Rot
      ```
    ]
  )
)

== let, set, show

#grid(
  columns: (1fr, )*2,
  gutter: 1cm, 
  [ 
    Platz zum Lösen:
    #schreibpapier(height: 5cm)
  ],
  [
    
    #codly(header: [*Eigene Funktion*], skips: ((2, 21), ))
    ```typst
    #let schreibpapier(height: none, size: 4mm) = ...
    Platz zum Lösen:
    #schreibpapier(height: 5cm)
    ```
  ]
)

#slide(
  grid(
    columns: (1fr, )*2,
    gutter: 1cm, 
    [ 
      Viel Platz zum Lösen
      #schreibpapier()
    ],
    [ 
      #codly(header: [*Default nutzen*])
      ```typst
      Viel Platz zum Lösen
      #schreibpapier()
      ```
    ]
  )
)

#slide(
  grid(
    columns: (1fr, )*2,
    gutter: 1cm, 
    [ 
      Standardwert der Höhe geändert
      #let schreibpapier = schreibpapier.with(height: 7cm)
      #schreibpapier()
    ],
    [ 
      #codly(header: [*Eigene Funktion ändern*])
      ```typst
      Standardwert der Höhe geändert
      #let schreibpapier = schreibpapier.with(height: 7cm)
      #schreibpapier()
      ```
    ]
  )
)

#slide(
  grid(
    columns: (1fr, )*2,
    gutter: 1cm, 
    [ 
      Vorgaben für vorgegebene Funktionen anpassen
      #set math.equation(numbering: "(i)")
  
      $ 1 + 1 = 2 $
    ],
    [ 
      #codly(header: [*Std-Funktion ändern*])
      ```typst
      Vorgaben für vorgegebene Funktionen anpassen
      #set math.equation(numbering: "(i)")
  
      $ 1 + 1 = 2 $
      ```
    ]
  )
)

#slide(
  grid(
    columns: (1fr, )*2,
    gutter: 1cm, 
    [ 

      Inhalt kann auch verändert werden.
      #show grid: set grid.cell(stroke: 1pt + red)
      #schreibpapier(height: 5cm)
      
    ],
    [ 
      
        #codly(header: [*Eigene Funktion ändern*])
        ```typst
        Inhalt kann auch verändert werden.
        #show grid: set grid.cell(stroke: 1pt + red)
        #schreibpapier(height: 5cm)
        ```
        #pause

        $=>$ Änderung ist lokal, hier nur im Rahmen dieser Folie.
    ]
  )
)

#slide(
  grid(
    columns: (1fr, )*2,
    gutter: 1cm, 
    [ 
      Das alte Verhalten ist wieder da
      #schreibpapier(height: 5cm)
    ],
    [ 
      #codly(header: [*Eigene Funktion ändern*])
      ```typst
      Das alte Verhalten ist wieder da
      #schreibpapier(height: 5cm)
      ```
    ]
  )
)

#slide(
  grid(
    columns: (1fr, )*2,
    gutter: 1cm, 
    {
      show "H2O": [H#sub[2]O]
      [H2O]
    },
    [ 
      #codly(header: [*Text ersetzen*])
      #show "H2O": it => it.text
      ```typst
      #show "H2O": [H#sub[2]O]

      H2O
      ```
    ]
  ) 
)

#slide(
  grid(
    columns: (auto , 1fr ),
    gutter: 1cm, 
    {
      show regex("([A-Z][a-z]?)-(\d+)(?:-(\d+))?"): it => {
        let parts = it.text.split("-")
        let name = parts.at(0)
        let a = parts.at(1)
        
        if parts.len() == 3 {
          let z = parts.at(2)
          $physica.isotope(name, a: #a, z: #z)$
        } else {
          $physica.isotope(name, a: #a)$
        }
      }
      [He-4 ist stabil U-235-92 nicht]
    },
    [ 
      #codly(header: [*komplexen Text ersetzen*])
      ```typst
      #show regex("([A-Z][a-z]?)-(\d+)(?:-(\d+))?"): it => {
        let parts = it.text.split("-")
        let name = parts.at(0)
        let a = parts.at(1)  
        if parts.len() == 3 {
          let z = parts.at(2)
          $isotope(name, a: #a, z: #z)$
        } else {
          $isotope(name, a: #a)$
        }
      }
      He-4 ist stabil U-235-92 nicht
      ```
    ]
  )   
)

== Zeichnungen

#grid(
  columns: (1fr, )*2,
  gutter: 1cm, 
  [ 
    #cetz.canvas({
      import cetz.draw: *
      circle((), name: "c")
      rect((6, -1), (rel: (2, 2)), name: "r")
      line("c", "r", stroke: eth-theme-colors.primary, mark: (end: "barbed", scale: 3))
    })
  ],
  [ 
    #codly(header: [*Zeichnung*])
    ```typst
    #import "@preview/cetz:0.4.2"
    #cetz.canvas({
      import cetz.draw: *
      circle((), name: "c")
      rect((6, -1), (rel: (2, 2)), name: "r")
      line("c", "r", stroke: eth-theme-colors.primary, mark: (end: "barbed", scale: 3))
    })
    ```
  ]
)

#slide({
  figure({
    let electric-field(pos, charges) = {
      let ex = 0.0
      let ey = 0.0
      for c in charges {
        let dx = pos.at(0) - c.pos.at(0)
        let dy = pos.at(1) - c.pos.at(1)
        let dist-sq = calc.max(calc.pow(dx, 2) + calc.pow(dy, 2), 0.01)
        let dist = calc.sqrt(dist-sq)
        ex += (c.q / dist-sq) * (dx / dist)
        ey += (c.q / dist-sq) * (dy / dist)
      }
      (ex, ey)
    }
  
    let pos = gradient.radial(white, red, center: (25%, 25%))
    let neg = gradient.radial(white, blue, center: (25%, 25%))
  
    let bounding-box = (8, 6)
  
    cetz.canvas({
      import cetz.draw: *
      
      let charges = (
        (id: 0, pos: (-2, 0), q: 1.8), 
        (id: 1, pos: (2, 0), q: -1),
      )
      
      let num-lines = 20
      let step-size = 0.05
      let max-steps = 500
      let proximity-threshold = 0.15
      let angle-tolerance = 15deg      // Für belegte Winkel (Phase 2)
      let exclude-angle-range = 15deg  // Für gleichnamige Sperrzone
      let max-distance = 7.0 
      
      let used-angles = (:)
      for c in charges { used-angles.insert(str(c.id), ()) }
  
      // --- PHASE 1: Positive Ladungen (Quellen) ---
      for c-start in charges.filter(c => c.q > 0) {
        for i in range(num-lines) {
          let start-angle = i * (360deg / num-lines)
          
          // 1. Check: Sperrzone für gleichnamige Ladungen
          let blocked-by-same = false
          for c-other in charges.filter(c => c.id != c-start.id and c.q > 0) {
            let angle-to-other = calc.atan2(c-other.pos.at(0) - c-start.pos.at(0), c-other.pos.at(1) - c-start.pos.at(1))
            let diff = calc.abs(start-angle - angle-to-other)
            if diff > 180deg { diff = 360deg - diff }
            if diff < exclude-angle-range { blocked-by-same = true; break }
          }
          if blocked-by-same { continue }
  
          // Integration vorwärts
          let current-pos = (c-start.pos.at(0) + calc.cos(start-angle) * proximity-threshold, c-start.pos.at(1) + calc.sin(start-angle) * proximity-threshold)
          let points = (current-pos,)
          for _ in range(max-steps) {
            let field = electric-field(current-pos, charges)
            let mag = calc.sqrt(calc.pow(field.at(0), 2) + calc.pow(field.at(1), 2))
            current-pos = (current-pos.at(0) + (field.at(0) / mag) * step-size, current-pos.at(1) + (field.at(1) / mag) * step-size)
            points.push(current-pos)
  
            if calc.abs(current-pos.at(0)) > bounding-box.at(0) or calc.abs(current-pos.at(1)) > bounding-box.at(1) {
              break
            }
            
            let hit = false
            for c-other in charges.filter(c => c.id != c-start.id) {
              let dx = current-pos.at(0) - c-other.pos.at(0)
              let dy = current-pos.at(1) - c-other.pos.at(1)
              if calc.sqrt(dx*dx + dy*dy) < proximity-threshold {
                if c-other.q < 0 { used-angles.at(str(c-other.id)).push(calc.atan2(dx, dy)) }
                hit = true; break
              }
            }
            if hit { break }
          }
          line(..points, stroke: 1pt + yellow)
        }
      }
  
      // --- PHASE 2: Negative Ladungen (Senken) ---
      for c-start in charges.filter(c => c.q < 0) {
        for i in range(num-lines) {
          let start-angle = i * (360deg / num-lines)
          
          // 1. Check: Sperrzone für gleichnamige (Negative -> Negative)
          let blocked-by-same = false
          for c-other in charges.filter(c => c.id != c-start.id and c.q < 0) {
            let angle-to-other = calc.atan2(c-other.pos.at(0) - c-start.pos.at(0), c-other.pos.at(1) - c-start.pos.at(1))
            let diff = calc.abs(start-angle - angle-to-other)
            if diff > 180deg { diff = 360deg - diff }
            if diff < exclude-angle-range { blocked-by-same = true; break }
          }
          if blocked-by-same { continue }
  
          // 2. Check: Bereits belegt durch ankommende Linie aus Phase 1
          let occupied = false
          for used in used-angles.at(str(c-start.id)) {
            if used < 0deg { used = 360deg + used }
            let diff = calc.abs(start-angle - used)
            if diff > 180deg { diff = 360deg - diff }
            if diff < angle-tolerance { occupied = true; break }
          }
          if occupied { continue }
  
          // Integration rückwärts
          let current-pos = (c-start.pos.at(0) + calc.cos(start-angle) * proximity-threshold, c-start.pos.at(1) + calc.sin(start-angle) * proximity-threshold)
          let points = (current-pos,)
          for _ in range(max-steps) {
            let field = electric-field(current-pos, charges)
            let mag = calc.sqrt(calc.pow(field.at(0), 2) + calc.pow(field.at(1), 2))
            current-pos = (current-pos.at(0) - (field.at(0) / mag) * step-size, current-pos.at(1) - (field.at(1) / mag) * step-size)
            points.push(current-pos)
            if calc.abs(current-pos.at(0)) > bounding-box.at(0) or calc.abs(current-pos.at(1)) > bounding-box.at(1) {
              break
            }
          }
          line(..points, stroke: 1pt + yellow)
        }
      }
  
      // Rahmen
      rect((-bounding-box.at(0), -bounding-box.at(1)), (bounding-box), stroke: .5pt)
      for c in charges { circle(c.pos, radius: 0.2, fill: if c.q > 0 { pos } else { neg }, stroke: none) }
    })
  })
})

#slide(
    figure({
    cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *
      
      // Die Spulen-Funktion (entspricht deiner \coil Definition)
      let coil_func(t, n) = (
        0.3 * (2 * n + t) + 0.4 * calc.sin(t * calc.pi),
        1.5 * calc.cos(t * calc.pi)
      )

      // Ein Plot-Objekt erstellen, das die Achsen versteckt (wie in TikZ)
      plot.plot(size: (10, 4), x-tick-step: none, y-tick-step: none, axis-style: none, {
          
        // 1. Hintere Windungen
        for n in range(0, 11) {
          plot.add(t => coil_func(t, n), domain: (0, 1), style: (stroke: 0.5pt))
        }

        // 2. Vordere Windungen mit "Fake-Preaction" (weiß drunter)
        for n in range(0, 11) {
          plot.add(t => coil_func(t, n), domain: (1, 2), style: (stroke: 4pt + white))
          plot.add(t => coil_func(t, n), domain: (1, 2), style: (stroke: 1.5pt + black))
        }
        // 3. Anschlüsse (Beispielhaft analog zu deinem Code)
        plot.add(t => coil_func(t, 0), domain: (-0.5, 0), style: (stroke: 1.5pt))
        plot.add(t => coil_func(t, 11), domain: (0, 0.5), style: (stroke: 0.5pt))
      })        
      // Pfeile für den Stromfluss
      line((0, 2), (0, -1), stroke: 1.5pt)
      line((0, 1), (0, 0), mark: (start: "barbed"), name: "current", stroke: red +1.5pt)
      content("current.mid", text(fill: red)[ $arrow(I)$ ], anchor: "east", padding: .2)
      line((10, 2), (10, -1), stroke: .5pt)
      line((10, 1), (10, 0), mark: (end: "barbed"), name: "current", stroke: red +1.5pt)
      content("current.mid", text(fill: red)[ $arrow(I)$ ], anchor: "east", padding: .2)
    })
  })
)

#slide(
  align(center)[
    //#show math.equation: set text(font: "TeX Gyre Pagella Math", size: 16pt)
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *
  
      
      scale(1.5)
      // Magnet
      scope({
        rotate(45deg)
        rect((-1, -.25), (rel: (1, .5)), stroke: green, fill: green.lighten(80%))
        content((-.7, 0), [#std.rotate(-45deg)[#text(fill: green, size: 18pt)[S]]])
        rect((0, -.25), (rel: (1, .5)), stroke: red, fill: red.lighten(80%))
        content((.7, 0), [#std.rotate(-45deg)[#text(fill: red, size: 18pt)[N]]])
      })
      circle((), radius: 1pt, stroke: blue, fill: blue)
  
      // L1
      cetz.decorations.coil(line((-180deg, 1.5), (rel: (-180deg, 1.5))), stroke: brown, name: "L1")
      line("L1.end", (rel: (0, 1)), stroke: brown, mark: (end: "barbed"), name: "L1_p")
  
      // L2
      cetz.decorations.coil(line((60deg, 1.5), (rel: (60deg, 1.5))), stroke: black, name: "L2")
      line("L2.end", (rel: (-30deg, 1)), stroke: black, mark: (end: "barbed"), name: "L2_p")
  
      // L3
      cetz.decorations.coil(line((-60deg, 1.5), (rel: (-60deg, 1.5))), stroke: gray, name: "L3")
      line("L3.end", (rel: (-150deg, 1)), stroke: gray, mark: (end: "barbed"), name: "L3_p")
  
      // Neutralleiter
      arc((-180deg, 1.5), start: 180deg, delta: -270deg, radius: 1.5, stroke: blue, mark: (end: "barbed"), name: "N")
  
      // Beschriftungen
      content("L1_p.end", text(fill: brown)[$L_1$], anchor: "south", padding: 2pt)
      content("L2_p.end", text(fill: black)[$L_2$], anchor: "north-west", padding: 2pt)
      content("L3_p.end", text(fill: gray)[$L_3$], anchor: "east", padding: 2pt)
      content("N.end", text(fill: blue)[$N$], anchor: "east", padding: 2pt)
  
      // Diagramm
      scope({
        translate(x: 5, y: -2.5)
        set-style(axes: (overshoot: 15pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)
  
        plot.plot(axis-style: "school-book", size: (7,5), x-tick-step: none, y-tick-step: none, x-label: [$t$], y-label: [$U$], x-ticks: ((2*calc.pi, [$T$]), ), y-ticks: ((1, [$hat(U)$]), ), name: "yt", {
          plot.add(y => (calc.sin(y)), domain: (0, 2.5*calc.pi), style: (stroke: brown))
          plot.add(y => (calc.sin(y - 2*calc.pi/3)), domain: (0, 2.5*calc.pi), style: (stroke: black))
          plot.add(y => (calc.sin(y - 4*calc.pi/3)), domain: (0, 2.5*calc.pi), style: (stroke: gray))
          plot.add(((0, 0), (2.5*calc.pi, 0)), style: (stroke: blue))
        })
        content((7.2, 5), text(fill: brown)[$L_1$])
        content((7.2, 0.75), text(fill: black)[$L_2$])
        content((7.2, 1.75), text(fill: gray)[$L_3$])
        content((7.2, 2.75), text(fill: blue)[$N$])
      })
    })
  ]
)

== Diagramme

#grid(
  columns: (1fr, )*2,
  gutter: 1cm, 
  [ 
    #cetz.canvas({
      import cetz-plot: *
      plot.plot(size: (10,10), x-tick-step: none, y-tick-step: none, axis-style: "school-book", {
       plot.add(domain: (0, 4*calc.pi), calc.sin)
      })
    })
  ],
  [ 
    #codly(header: [*Diagramm*])
    ```typst
    #import "@preview/cetz:0.4.2"
    #import "@preview/cetz-plot:0.1.3"
    #cetz.canvas({
      import cetz-plot: *
      plot.plot(size: (10,10), x-tick-step: none, y-tick-step: none, axis-style: "school-book", {
       plot.add(domain: (0, 4*calc.pi), calc.sin)
      })
    })
    ```
  ]
)

#slide({
  grid(
    columns: (1fr, 1fr),
    align: (center),
    row-gutter: 1em,
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *
    
        let r = 2
        let x_0 = 0.1 //Anfangspopulation
          
        plot.plot(axis-style: "scientific", x-label: [$x_n$], y-label: [$x_(n+1)$], size: (8,8), x-tick-step: .5,  x-minor-tick-step: .1, y-tick-step: .5, y-minor-tick-step: .1,{
          plot.add(((0, 0), (1, 1)), style: (stroke: gray))
          plot.add(y => (r*y*(1-y)), domain: (0, 1), style: (stroke: green))
          let x_m = r*x_0*(1-x_0)
          plot.add(((x_0, 0), (x_0, x_m), (x_m, x_m)), style: (stroke: eth-theme-colors.primary))
          let x_n = x_m
          for i in range(20){
            x_m = r*x_n*(1-x_n)
            plot.add(((x_n, x_n), (x_n, x_m), (x_m, x_m)), style: (stroke: eth-theme-colors.primary))
            x_n = x_m
          }
        })
      })
    ],
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *
    
        let r = 3
        let x_0 = 0.14 //Anfangspopulation
          
        plot.plot(axis-style: "scientific", x-label: [$x_n$], y-label: [$x_(n+1)$], size: (8, 8), x-tick-step: .5,  x-minor-tick-step: .1, y-tick-step: .5, y-minor-tick-step: .1, {
          plot.add(((0, 0), (1, 1)), style: (stroke: gray))
          plot.add(y => (r*y*(1-y)), domain: (0, 1), style: (stroke: green))
          let x_m = r*x_0*(1-x_0)
          plot.add(((x_0, 0), (x_0, x_m), (x_m, x_m)), style: (stroke: eth-theme-colors.primary))
          let x_n = x_m
          for i in range(20){
            x_m = r*x_n*(1-x_n)
            plot.add(((x_n, x_n), (x_n, x_m), (x_m, x_m)), style: (stroke: eth-theme-colors.primary))
            x_n = x_m
          }
        })
      })
    ],
    [$r=2$], [$r=3$]
  )
})

#slide({
  grid(
    columns: (1fr, 1fr),
    align: (center),
    row-gutter: 1em,
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *
    
        let r = 3.54
        let x_0 = 0.0991 //Anfangspopulation
          
        plot.plot(axis-style: "scientific", x-label: [$x_n$], y-label: [$x_(n+1)$], size: (8, 8), x-tick-step: .5,  x-minor-tick-step: .1, y-tick-step: .5, y-minor-tick-step: .1, {
          plot.add(((0, 0), (1, 1)), style: (stroke: gray))
          plot.add(y => (r*y*(1-y)), domain: (0, 1), style: (stroke: green))
          let x_m = r*x_0*(1-x_0)
          plot.add(((x_0, 0), (x_0, x_m), (x_m, x_m)), style: (stroke: eth-theme-colors.primary))
          let x_n = x_m
          for i in range(20){
            x_m = r*x_n*(1-x_n)
            plot.add(((x_n, x_n), (x_n, x_m), (x_m, x_m)), style: (stroke: eth-theme-colors.primary))
            x_n = x_m
          }
        })
      })
    ],
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *
    
        let r = 3.57
        let x_0 = 0.099 //Anfangspopulation
          
        plot.plot(axis-style: "scientific", x-label: [$x_n$], y-label: [$x_(n+1)$], size: (8, 8), x-tick-step: .5,  x-minor-tick-step: .1, y-tick-step: .5, y-minor-tick-step: .1, {
          plot.add(((0, 0), (1, 1)), style: (stroke: gray))
          plot.add(y => (r*y*(1-y)), domain: (0, 1), style: (stroke: green))
          let x_m = r*x_0*(1-x_0)
          plot.add(((x_0, 0), (x_0, x_m), (x_m, x_m)), style: (stroke: eth-theme-colors.primary))
          let x_n = x_m
          for i in range(20){
            x_m = r*x_n*(1-x_n)
            plot.add(((x_n, x_n), (x_n, x_m), (x_m, x_m)), style: (stroke: eth-theme-colors.primary))
            x_n = x_m
          }
        })
      })
    ],
    [$r=3.54$], [$r=3.57$]
  )
})

#slide(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *
  
      // Formatierung der einzelnen Punkte
      let punkt = (style: (stroke: none), mark: "o", mark-size: .5pt, mark-style: (fill: black, stroke: none))
  
      let r_min = 2.8 // Zwischen welchen Werten soll r dargestellt werden
      let r_max = 4 
  
      let delta_r = 0.0025 // Differenz zwischen 2 benachbarten r
      
      set-style(stroke: .5pt)
  
      plot.plot(axis-style: "scientific", x-label: [$r$], y-label: [$x$], y-tick-step: none, size: (16, 8), {
        let r = r_min
        let r_range = 5
        while r < r_max{
          let x_n = .1
          let data = ()
          for _ in range(50){
            let x_m = r*x_n*(1-x_n)
            x_n = x_m
          }
          if r > 3.5{
            r_range = 10 //100
          }
          for _ in range(r_range){
            let x_m = r*x_n*(1-x_n)
            data.push((r, x_m))
            x_n = x_m
          }
          plot.add((data), ..punkt)
          r += delta_r
        }
      })
    })
  ]
)

= Tipps für den Einstieg

== Online 

Typst kann direkt online verwendet werden:
#v(3em)
#align(center)[#text(fill: eth-theme-colors.primary, size: 30pt)[#link("https://typst.app/")]]

#slide([
  - 200Mb Speicherplatz, maximal 200 Dateien
  #pause
  
  - Daten werden in der Azure-Cloud in Deutschland gespeichert (Datenschutzkonform)
  #pause

  - Das Compilieren erfolgt im eigenen Browser (wasm)
  #pause

  - Autocomplete, Hilfen bei der Fehlersuche
])

== Online mit Abo

Typst lässt sich auch im Abo (80€ im Jahr) nutzen:

- Anbindung an Literatur-Datenbank (Zotero, Mendeley)

- Anbindung an gihub/gitlab zur Versionsverwaltung

- 2GB Speicherplatz, maximal 1000 Dateien

- Präsentationen direkt von der Webapp möglich

#pause
#v(2cm)
Ich habe kein Abo und nutze alle Vorteile (und mehr!) in meiner Offline-Installation.

== Nützliche Pakete

Die Funktionalität von typst lässt sich durch Pakete erweitern:

- "cetz" und "cetz-plot" für Zeichnungen und Diagramme

- "unify" für Einheiten

- "physica" für vereinfachte Eingabe von Formeln, Isotopen, ...

- "zap" für Schaltkreise

- "itemize" für korrekt ausgerichtete Aufzählungen

#v(1em)
Weitere sind im "Universe" aufgeführt:

#align(center)[#link("https://typst.app/universe/")]

== Mit einem Template beginnen

Das Rad muss nicht immer neu erfunden werden!

Man lernt viel von den anderen.

== Hilfe

Die Community ist gross und hilfsbereit:

- Forum: #link("https://forum.typst.app/")

- Discord: #link("https://discord.gg/2uDybryKPe")

- weitere Kanäle, die ich nicht nutze

#pause
Die KI kennt Typst noch nicht so gut. Wandelt aber recht gekonnt #(LaTeX)-Dateien (inkl. TikZ-Zeichnungen) in Typst um.

= Übung

== Konto online eröffnen

#align(center)[#text(fill: eth-theme-colors.primary, size: 30pt)[#link("https://typst.app/")]]

== Start-Code

#codly(header: [Start])

```typst
#import "@preview/accelerated-jacow:0.14.0": jacow
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3"
#import "@preview/physica:0.9.8": *

#show: jacow.with(
  title: [Mein erstes Paper in Typst],
  authors: ((name: "Vorname Name", mail: "vorname.nachname@ethz.ch", at: "eth")),
  affiliations: (eth: "ETHZ"),
  abstract: [ #lorem(20) ],
)
= Meine erste Überschrift
Ein wichtiges Isotop: $isotope("He", a: 4, z: 2)$

#lorem(800)
```

== Weitere Beispiele

#align(center)[#text(fill: eth-theme-colors.primary, size: 30pt)[#link("https://github.com/christianprim/")]]
