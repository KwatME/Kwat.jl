using Test: @test

using Omics

# ---- #

# 10.666 ns (0 allocations: 0 bytes)
# 10.135 ns (0 allocations: 0 bytes)
# 10.636 ns (0 allocations: 0 bytes)
# 10.125 ns (0 allocations: 0 bytes)
# 10.636 ns (0 allocations: 0 bytes)
# 8.916 ns (0 allocations: 0 bytes)
# 10.677 ns (0 allocations: 0 bytes)
# 8.884 ns (0 allocations: 0 bytes)

for (x1, y1, re) in ((1, 1, 1 / 3), (-1, 1, 2 / 3), (-1, -1, 4 / 3), (1, -1, 5 / 3))

    y1 *= sqrt(3)

    an, ra = Omics.Coordinate.convert_cartesian_to_polar(x1, y1)

    @test isapprox(an, pi * re)

    @test isapprox(ra, 2.0)

    #@btime Omics.Coordinate.convert_cartesian_to_polar($x1, $y1)

    x2, y2 = Omics.Coordinate.convert_polar_to_cartesian(an, ra)

    @test isapprox(x1, x2)

    @test isapprox(y1, y2)

    #@btime Omics.Coordinate.convert_polar_to_cartesian($an, $ra)

end

# ---- #

const DI = [
    0 1 2 3 4 5
    1 0 3 4 5 6
    2 3 0 5 6 7
    3 4 5 0 7 8
    4 5 6 7 0 9
    5 6 7 8 9 0.0
]

const NP = size(DI, 1)

const CA = Omics.CartesianCoordinate.ge(DI)

const AN_ = Omics.PolarCoordinate.ge!(DI)

const XY_ = map(Omics.Coordinate.convert_polar_to_cartesian, AN_, ones(NP))

const TR = Dict("text" => 1:NP, "mode" => "text", "textfont" => Dict("size" => 24))

Omics.Plot.plot(
    "",
    (
        Omics.Dic.merg(
            Dict(
                "name" => "Cartesian",
                "y" => CA[2, :],
                "x" => CA[1, :],
                "textfont" => Dict("color" => Omics.Color.A1),
            ),
            TR,
        ),
        Omics.Dic.merg(
            Dict(
                "name" => "Polar",
                "y" => map(xy -> xy[2], XY_),
                "x" => map(xy -> xy[1], XY_),
                "textfont" => Dict("color" => Omics.Color.A2),
            ),
            TR,
        ),
    ),
    Dict("height" => 800, "width" => 800),
)
