---@diagnostic disable undefined-global

return {
  s(
    "err",
    fmt(
      [[
        {}, err := {}
        if err != nil {{
          {}
        }}
      ]],
      { i(1), i(2), i(3) }
    )
  ),
  s(
    "err",
    fmt(
      [[
        if {} != nil {{
          {}
        }}
      ]],
      { i(1, "err"), i(2) }
    )
  ),
  s(
    "err",
    fmt(
      [[
        if {}err := {}; err != nil {{
          {}
        }}
      ]],
      { i(1), i(2), i(3) }
    )
  ),
  s(
    "fpr",
    fmt(
      [[
        fmt.Printf("{}\n", {})
      ]],
      { i(1), i(2) }
    )
  ),
  s(
    "fpr",
    fmt(
      [[
        fmt.Print("{}\n")
      ]],
      { i(1) }
    )
  ),
  s(
    "log",
    fmt(
      [[
        log.Printf("{}", {})
      ]],
      { i(1), i(2) }
    )
  ),
  s(
    "log",
    fmt(
      [[
        log.Print("{}")
      ]],
      { i(1) }
    )
  ),
}
