-- Awful tags and apps configuration
tags_type = "awful"

-- Tags definition
tags = {
    { names = {
        "1:web",
        "2:mail",
        "3:term",
        "4:dev",
        "5:sys",
        "6:fs",
        "7:im",
        "8:off",
        "9:img"},
    layout = {
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2]}
    },
    { names = {
        "1:web",
        "2:mail",
        "3:term",
        "4:dev",
        "5:sys",
        "6:fs",
        "7:im",
        "8:off",
        "9:img"},
    layout = {
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2],
        layouts[2]}
    },
}

for s = 1, screen.count() do
    tags[s] = awful.tag(tags[s].names, s, tags[s].layout)
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
