// Nützliche Pakete
#import "@preview/unify:0.7.1": unit, qty, num
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3"
#import "@preview/numbly:0.1.0": numbly
#import "@preview/physica:0.9.8": *

//Sprache auf Deutsch (Schweiz) setzen. Liefert auch folgende Anführungszeichen: «», wer Lieber die hoch- und tiefgestellten Gänsefüsschen will, setz DE als Region
#set text(lang: "de", region: "CH")

// Blocksatz wird auf der Ebene Paragraf festgelegt:
#set par(justify: true)

// Mit dem Befehl heading werden die Überschriften gesetzt. Hier wird die Schrift angepasst, die Farbe auf Dunkelblau geändert und der Stil auf kursiv gesetzt:
#show heading: set text(font: "TeX Gyre Heros", style: "italic", fill: blue.darken(50%))

// Die Hauptüberschrift wird mit folgendem Befehl wieder normal gesetzt. Der Befehl emph ändert von kursiv zu normal oder zurück:
#show heading.where(level: 1): it => emph[#it]

// Mathematischer Formelsatz mit Libertinus Math setzen, wie der Standardtext:
#show math.equation: set text(font: "Libertinus Math")

// Kopf und Fusszeilen. Da diese Zeilen auf jeder Seite neu berechnet werden müssen, greift man auf die Funktion context zurück. Denn woher soll here() an dieser Stelle wissen, wo sich die gesetzte Seite gerade befindet? Das ist ein grundsätzliches Problem, wenn eine echte, funktionale Skriptsprache in einem Satzprogramm verwendet werden soll.

#set page(
  header: [Test-Dokument#h(1fr)Emmetten 2026],
  footer: context({
    let page-number = here().page()
    if calc.odd(page-number){
      [#h(1fr)#page-number]
    } else {
      [#page-number]
    }
  })
)

= Eine Überschrift

== Eine Unterüberschrift

Ein wichtiges Isotop ist $isotope("He", a: 4, z: 2)$. Aber das ist stark subjektiv, also vom "Geschmack" abhängig.

Das ist eine Formel im laufenden Text: $arrow(F)_"res"=m arrow(a)$. Zum Textvergleich sind die folgenden Buchstaben mit der regulären kursiven Schrift gesetzt: _ma_. Es handelt sich also um die gleiche Schriftart.

Eine Formel, die die ganze Zeile ausfüllt:

$ integral_0^oo x dif x $

Oder hier mit einer Fallunterscheidung:

$ f(x, y) := cases(
  1 "falls" (x dot y)/2 <= 0,
  2 "falls" x "gerade ist",
  3 "falls" x in NN,
  4 "sonst",
) $

Zurück zur Physik:

$ #text(green, $x$)=#text(green, $x_0$)+#text(blue, $v_0$)t + #text(red, $a$)/2 t^2 $

Oder mit einem Diagramm:

#figure(
  cetz.canvas({
    import cetz-plot: *
    import cetz.draw: *
    
    set-style(axes: (overshoot: 7pt, shared-zero: false, stroke: 0.5pt, tick: (stroke: 0.5pt), x: (mark: (end: "barbed")), y: (mark: (end: "barbed"))), stroke: 0.5pt)

    plot.plot(axis-style: "left", size: (5,3), x-tick-step: none, y-tick-step: none, x-label: [$t$], y-label: text(fill: blue)[$v$], x-ticks: ((1, [$t$]), ), y-ticks: ((0.3, [#text(fill: blue)[$v_0$]]), ), name: "vt", {
      plot.add(((0,0.3), (1.1, .99)), style: (stroke: blue))
      plot.add-fill-between(((0, 0.3), (1, 0.93)), ((0, 0), (1, 0)), style: (stroke: none, fill: green.transparentize(80%)))
      plot.add(((1, 0), (1, 0.3)), style: (stroke: (paint: black, dash: "dashed")))
      plot.add(((1, 0.3), (1, 0.93)), style: (stroke: blue))
      plot.add(((0, 0.3), (1, 0.3)), style: (stroke: black))
      plot.add-anchor("t", (0.5, 0))
      plot.add-anchor("x_1", (0.5, 0.15))
      plot.add-anchor("x_2", (0.7, 0.5))
      plot.add-anchor("v", (1, 0.61))
    })
    content("vt.t", [$Delta t$], anchor: "north", padding: 3pt)
    content("vt.v", text(fill: blue)[$Delta v$], anchor: "west", padding: 3pt)
    content("vt.x_1", text(fill: green)[$Delta x_1$])
    content("vt.x_2", text(fill: green)[$Delta x_2$])
  }), caption: [Ein #text(blue, $v$)-$t$-Diagramm]
)<fig:v-t>

= Eine weitere Überschrift

#grid(
  columns: (1fr, auto),
  gutter: .5cm,
  align: horizon,
  [
    #lorem(100)
  ],
  [
    #cetz.canvas({
      import cetz.draw: *
      set-style(stroke: .5pt)

      circle((), stroke: red, name: "kreis")
      for angle in range(359, step: 45){
        circle((angle*1deg, 1.5), radius: .25, stroke: orange, name: "kleiner Kreis")
        line("kreis", "kleiner Kreis")
      }
    })
  ]
)

Wie bereits in @fig:v-t dargestellt wurde, #lorem(50)

= Eine letzte Überschrift

+ Ein erster Punkt
+ Ein weiterer Punkt
  - Eine Aufzählung
  - ein weiterer Punkt
  - kann noch weiter verschachtelt werden.

// Anpassung der nummerierten Liste: (der Punkt dient nur zum Trennen der einzelnen Levels)
#set enum(numbering: "1.a)")

+ Eine erste Aufgabe
  + eine Unteraufgabe
  + eine weitere Unteraufgabe

// Mit dem Zusatzpaket numbly, lässt sich auch das Trennzeichen anpassen
#set enum(full: true, numbering: numbly("{1}.", "{2:a})"))

+ Eine erste Aufgabe
  + eine Unteraufgabe
  + eine weitere Unteraufgabe

== Eine letzte Unterüberschrift

Bilder lassen sich auch ohne Legende einfügen#footnote[Das sollte aber nur bei reinen Design-Elementen angewendet werden]:

#image("figs/bg_eth.jpg")

#lorem(50) Siehe auch @tab:dietikon. 

#lorem(50)

#figure(
  table(
    columns: 6,
    align: (center, center, right, right, right, left),
    stroke: none,
    fill: (x, y) =>
    if x == 0 or y == 0 {
      aqua.lighten(40%)
    },
    table.header(
      table.hline(start: 0, stroke: 0.5pt + blue),
      align(horizon)[Jahr], [Gefälle \ in m], align(center)[Wassermenge \ in #unit("m^3/s")], align(center)[Installierte Leistung \ in PS], [Produktion \ in kWh#unit("/a")], [],
    ),
    table.vline(stroke: 0.5pt + blue), 
    table.vline(x: 0, stroke: 0.5pt + blue),
    text(number-type: "old-style")[1908], [], [], [], [#num("1220000")], [Übernahme EKZ],  
    text(number-type: "old-style")[1931], [], [], [], [#num("4050000")], [vor Umbau],
    text(number-type: "old-style")[1934], [$2.8-4.1$], [80], [#num("3400")], [#num("16500000")], [nach Umbau], 
    text(number-type: "old-style")[1942], [$2.8-4.8$], [100], [#num("4000")], [#num("19300000")], [nach Höherstau],
    table.hline(start: 0, stroke: 0.5pt + blue)
  ), caption: [Daten zum Flusskraftwerk Dietikon]
)<tab:dietikon>
