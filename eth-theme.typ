/**
 * Typst Touying theme for ETH presentations
 *
 * @author Thomas Moerschell <tmoerschell@ethz.ch>
 * Contribute to this at https://gitlab.ethz.ch/tmoerschell/typst-eth-theme
 */

#import "@preview/touying:0.6.1": *

/**
 * Footer (page numbering)
 */
#let footer(self) = {
  set align(bottom)
  let fs = self.store.base-font-size
  show: pad.with(.7 * fs)
  set text(fill: self.colors.neutral-darkest, size: .6 * fs)
  utils.call-or-display(self, self.store.footer)
  h(1fr)
  context utils.slide-counter.display()
}

/**
 * Layout of the title slide
 */
#let title-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()

  let fs = self.store.base-font-size
  let slide-margin = 1 * fs
  let top-banner-height = 2.5 * fs
  let banner-image-overlap = top-banner-height / 4

  // Top banner
  let header(self) = {
    set align(top + center)
    show: components.cell.with(
      fill: self.colors.primary,
      height: top-banner-height + slide-margin,
      outset: -0.5 * slide-margin,
      inset: 0.5 * slide-margin,
    )

    set align(top + left)
    image("figs/eth_logo_kurz_neg.svg", height: top-banner-height - banner-image-overlap)
  }

  let body = layout(size => {
    // Background image
    set align(top + center)
    let img-block = block(
      inset: (bottom: -50pt, top: -20pt),
      clip: true,
      image("figs/bg_eth.jpg"),
    )
    let img-size = measure(img-block, width: page.width - 2 * slide-margin)
    img-block

    // Bottom box
    set align(horizon + left)
    set text(fill: self.colors.neutral-lightest)
    let box-height = page.height - img-size.height - top-banner-height + banner-image-overlap - 1.5 * slide-margin
    show: components.cell.with(
      fill: self.colors.primary,
      width: 100%,
      height: box-height,
      inset: 1 * fs,
    )

    // Text
    text(size: 2 * fs, info.title)
    if info.author != none {
      linebreak()
      text(weight: "thin", info.author)
    }
    if info.date != none {
      set align(bottom + right)
      utils.display-info-date(self)
    }
  })

  // Configure and display slide
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      margin: (
        x: slide-margin,
        top: 0.5 * slide-margin + top-banner-height - banner-image-overlap,
        bottom: slide-margin,
      ),
    ),
  )
  touying-slide(self: self, body)
})

/**
 * Layout of section slides
 */
#let new-section-slide(self: none, body) = touying-slide-wrapper(self => {
  let main-body = {
    set align(horizon)
    text(
      size: 1.5 * self.store.base-font-size,
      fill: self.colors.primary,
      utils.display-current-heading(level: 1),
    )
    line(length: 100%, stroke: 4pt + self.colors.primary)
    body
  }
  self = utils.merge-dicts(
    self,
    config-page(
      footer: footer,
    ),
  )
  touying-slide(self: self, main-body)
})

/**
 * Layout of content slides
 */
#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }

  // Header
  let header(self) = {
    set align(top)
    let fs = self.store.base-font-size
    show: components.cell.with(
      fill: self.colors.primary,
      height: 3 * fs,
      inset: 3 * fs,
    )
    set align(horizon)
    set text(fill: self.colors.neutral-lightest, size: 1.5 * fs)
    if self.store.title != none {
      utils.call-or-display(self, self.store.title)
    } else {
      utils.display-current-heading(level: 2)
    }
  }

  // Configure and display slide
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  touying-slide(self: self, ..args)
})

/**
 * External definition of theme colors
 */
#let eth-theme-colors = (
  primary: rgb(31, 64, 122),
  neutral-lightest: rgb("#ffffff"),
  neutral-darkest: rgb("#000000"),
  red: rgb(230, 0, 0),
  green: rgb(64, 122, 31),
  orange: rgb(255, 165, 0),
)

#let eth-marker-colors = (
  item: eth-theme-colors.primary,
  subitems: eth-theme-colors.primary.lighten(30%),
)

/**
 * Layout bullet lists
 */
#let eth-marker(depth) = {
  let marker = {
    if depth <= 1 {
      sym.square.filled.medium
    } else {
      sym.triangle.r.filled
    }
  }
  let color = {
    if depth == 0 {
      eth-marker-colors.item
    } else {
      eth-marker-colors.subitems
    }
  }
  text(fill: color, marker)
}

#let eth-theme(
  aspect-ratio: "4-3",
  footer: none,
  base-font-size: 20pt,
  ..args,
  body,
) = {
  set text(font: "DejaVu Sans", size: base-font-size)
  set align(horizon)
  show heading.where(level: 1): set heading(numbering: "1.")
  set list(marker: eth-marker)


  show "code expert": box(
    height: .6em, // Less than 1em to ensure we do not grow larger than text
    inset: (bottom: -.045em),
    link(
      "https://expert.ethz.ch",
      image("figs/code_expert_logo.svg", height: 1.65em),
    ),
  )
  let x-inset = 5pt
  let padding = 5pt
  let colour = luma(180)

//   show raw.where(block: true): b => {
//     show raw.line: it => {
//       let num = text(.85em, fill: colour.darken(20%))[#it.number]
//       context {
//         let width = measure([#b.lines.len()]).width
//         let effective-pad = padding + x-inset 
//         [#h(-width -effective-pad) #box(width: width, align(right, num))#h(effective-pad)#box(width: 100%, it.body)]
//     }
//   }
  
//   set block(stroke: colour, inset: (x: x-inset, y: 5pt), radius: 3pt)
//   b
// }
  // show raw.where(block: true, lang: "cpp"): it => {
  //   box(
  //     stroke: 1pt + eth-theme-colors.primary,
  //     inset: 0.8em,
  //     radius: 0.25em,
  //     fill: luma(97%).transparentize(30%),
  //     width: 100%,
  //     it,
  //   )
  // }

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: 3.5em, bottom: 1.5em),
    ),
    config-common(
      new-section-slide-fn: new-section-slide,
      slide-fn: slide,
    ),
    config-methods(alert: utils.alert-with-primary-color),
    config-colors(..eth-theme-colors),
    config-store(
      title: none,
      footer: footer,
      base-font-size: base-font-size,
    ),
    ..args,
  )

  title-slide()
  body
}

/**
 * Utility functions
 */
#let external-link(dest, content) = {
  link(
    dest,
    box(
      fill: eth-theme-colors.primary,
      inset: (x: .5em),
      outset: (y: .3em),
      radius: .65em,
      text(fill: eth-theme-colors.neutral-lightest, size: 0.7em)[
        #box(
          fill: eth-theme-colors.neutral-lightest,
          radius: 0.2em,
          text(fill: eth-theme-colors.primary, weight: "bold", sym.arrow.tr),
        )
        #content
      ],
    ),
  )
}

#let highlight-box(content, color: eth-theme-colors.primary, ..args) = {
  box(
    fill: color.lighten(80%),
    stroke: color,
    inset: 0.8em,
    radius: 0.65em,
    ..args,
    content,
  )
}

#let good(content) = { highlight-box(content, color: eth-theme-colors.green) }
#let bad(content) = { highlight-box(content, color: eth-theme-colors.red) }

#let warning(content) = {
  set text(fill: eth-theme-colors.red)
  box(height: 1em, text(size: 1.8em, emoji.warning))
  [ ]
  content
}
#let info(content) = {
  set text(fill: eth-theme-colors.primary)
  set align(horizon)
  grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    box(
      height: 1em,
      circle(
        height: 1.8em,
        stroke: eth-theme-colors.primary,
        align(center, text(size: 1.4em, emoji.info)),
      ),
    ),
    box(content),
  )
}

#let checklist(content) = {
  set list(marker: text(fill: eth-theme-colors.primary, sym.square))
  content
}

#let bool(v) = if v {
  text(
    fill: eth-theme-colors.green,
    weight: "bold",
    raw("true"),
  )
} else {
  text(
    fill: eth-theme-colors.red,
    weight: "bold",
    raw("false"),
  )
}

// Fix layout bug when using #pause inside lists (https://github.com/touying-typ/touying/issues/136)
#let fix-list(pause-count, spacing: .55em) = only(
  (until: pause-count),
  v(-spacing), // Difference between list.spacing and par.spacing
)
