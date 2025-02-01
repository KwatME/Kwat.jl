using Test: @test

using Omics

# ---- #

for (nu, re) in ((pi, "3.1"),)

    @test Omics.Numbe.shorten(nu) === re

end

# ---- #

for (nu, re) in ((0, "0-5"), (5, "0-5"), (6, "6-18"), (18, "6-18"), (81, "81-"))

    @test Omics.Numbe.categorize(
        nu,
        (0, 6, 19, 41, 61, 81, Inf),
        ("0-5", "6-18", "19-40", "41-60", "61-80", "81-"),
    ) === re

end
