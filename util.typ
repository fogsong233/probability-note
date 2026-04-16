#let paper = rgb("#f4f3f0")
#let panel-fill = rgb("fbf8f1")
#let ink = rgb("2d241b")
#let muted = rgb("7a6754")
#let rule = rgb("cdbfaa")
#let accent = rgb("#0527d2")

#let panel(title, body, tint: muted) = block(
  above: 1em,
  below: 1em,
  width: 100%,
  inset: (x: 1.1em, y: 0.85em),
  fill: panel-fill,
  stroke: (left: 1.4pt + tint, top: 0.45pt + rule),
  radius: 2pt,
)[
  #text(font: "Baskerville", size: 9pt, weight: "semibold", fill: tint, tracking: 0.08em)[#title]
  #v(0.35em)
  #body
]

#let term(title, body) = panel(title, body, tint: accent)
#let coroll(body) = panel([Corollary], body)
#let notebox(body) = panel([Observation], body, tint: accent)
#let defn(concept, body) = panel([Def #text(fill: accent, size: 10pt)[#concept]], body)
#let theorem(body) = panel([Theorem], body, tint: accent)
#let note(body) = panel([Note], body, tint: accent)
#let example(body) = panel([Example], body, tint: rgb("8a5a44"))
#let proofblock(body) = panel([Proof], body, tint: rgb("5e5447"))
#let blu = cont => text(fill: accent)[#cont]
#let Ep = cont => $EE[cont]$
#let EX = $EE[X]$
#let Var = [*Var*]
#let Cov = [*Cov*]
#let Vol = math.op("Vol")
#let lim = math.op("lim")
#let log = math.op("log")
#let exp = math.op("exp")
#let Pois = math.op("Pois")
#let Geo = math.op("Geo")

#let eq-numbering = n => {
  let h = counter(heading).get()
  let sec = if h.len() >= 2 { h.at(1) } else if h.len() >= 1 { h.at(0) } else { 0 }
  numbering("(1.1)", sec, n)
}
