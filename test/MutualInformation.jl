using Omics

using Test: @test

# ----------------------------------------------------------------------------------------------- #

using Clustering: mutualinfo

using Random: seed!

using Statistics: cor

# ---- #

const JO = [
    1/8 1/16 1/16 1/4
    1/16 1/8 1/16 0
    1/32 1/32 1/16 0
    1/32 1/32 1/16 0
]

# ---- #

const P1_ = map(sum, eachrow(JO))

@test P1_ == [1 / 2, 1 / 4, 1 / 8, 1 / 8]

# ---- #

const P2_ = map(sum, eachcol(JO))

@test P2_ == [1 / 4, 1 / 4, 1 / 4, 1 / 4]

# ---- #

const E1 = Omics.Entropy.ge(eachrow, JO)

@test E1 === 7 / 4

# ---- #

const E2 = Omics.Entropy.ge(eachcol, JO)

@test E2 === 2.0

# ---- #

const EN = sum(Omics.Entropy.ge, JO)

@test EN === 27 / 8

# ---- #

const N2 = EN - E1

@test N2 ===
      sum(pr * sum(Omics.Entropy.ge, pr_ / pr) for (pr, pr_) in zip(P1_, eachrow(JO))) ===
      13 / 8

# ---- #

const N1 = EN - E2

@test N1 ===
      sum(pr * sum(Omics.Entropy.ge, pr_ / pr) for (pr, pr_) in zip(P2_, eachcol(JO))) ===
      11 / 8

# ---- #

const MU = E1 + E2 - EN

@test MU === E1 - N1 === E2 - N2 === 3 / 8

# ---- #

for (i1_, i2_, ri, rf) in (
    ([1, 2], [1, 2], 1.0, 1.0),
    ([1, 2], [1, 3], 1.0, 1.0),
    ([1, 2, 3], [1, 1, 2], 0.9168644108463501, 0.9140184400703142),
    ([1, 2, 3], [1, 1, 3], 0.9168644108463501, 0.9140184400703134),
    ([1, 2, 3], [1, 2, 1], 0.0, 0.0),
    ([1, 2, 3], [1, 2, 2], 0.9168644108463501, 0.9140184400703132),
    ([1, 2, 3], [1, 2, 3], 1.0, 1.0),
    ([1, 2, 3], [1, 3, 1], 0.0, 0.0),
    ([1, 2, 3], [1, 3, 2], 0.9787712969683778, 0.9749301137414429),
    ([1, 2, 3], [1, 3, 3], 0.9168644108463501, 0.9140184400703134),
    ([1, 2, 1, 2], [1, 2, 1, 2], 1.0, 1.0),
    ([1, 2, 1, 2], [1, 3, 1, 3], 1.0, 1.0),
    ([1, 2, 1, 2], [1, 2, 1, 3], 0.9298734950321937, 0.9269049805641628),
    ([1, 2, 1, 2], [1, 3, 1, 2], 0.9298734950321937, 0.9269049805641628),
    ([1, 2, 1, 2], [2, 1, 2, 1], -1.0, -1.0),
    ([1, 2, 1, 2], [3, 1, 3, 1], -1.0, -1.0),
    ([1, 2, 1, 2], [2, 1, 3, 1], -0.9298734950321937, -0.9269049805641624),
    ([1, 2, 1, 2], [3, 1, 2, 1], -0.9298734950321937, -0.9269049805641624),
)

    f1_ = convert(Vector{Float64}, i1_)

    f2_ = convert(Vector{Float64}, i2_)

    @test Omics.MutualInformation.get_information_coefficient(i1_, i2_) === ri

    @test Omics.MutualInformation.get_information_coefficient(f1_, f2_) === rf

end

# ---- #

# 18.208 ns (0 allocations: 0 bytes)
# 16.408 ns (0 allocations: 0 bytes)
# 81.736 ns (4 allocations: 1.84 KiB)
# 23.083 μs (54 allocations: 43.98 KiB)
# 245.497 ns (4 allocations: 288 bytes)
# 6.692 μs (4 allocations: 640 bytes)
# 257.696 ns (0 allocations: 0 bytes)
# 5.604 μs (0 allocations: 0 bytes)
# 490.979 ns (4 allocations: 1.84 KiB)
# 29.167 μs (54 allocations: 43.98 KiB)
# 113.825 ns (0 allocations: 0 bytes)
# 50.101 ns (0 allocations: 0 bytes)
# 232.973 ns (4 allocations: 1.84 KiB)
# 27.625 μs (54 allocations: 45.52 KiB)
# 562.611 ns (4 allocations: 288 bytes)
# 6.983 μs (4 allocations: 640 bytes)
# 494.201 ns (0 allocations: 0 bytes)
# 5.861 μs (0 allocations: 0 bytes)
# 992.455 ns (4 allocations: 1.84 KiB)
# 34.041 μs (54 allocations: 45.52 KiB)
# 1.150 μs (0 allocations: 0 bytes)
# 417.920 ns (0 allocations: 0 bytes)
# 1.746 μs (4 allocations: 1.84 KiB)
# 74.792 μs (57 allocations: 59.59 KiB)
# 807.511 ns (4 allocations: 288 bytes)
# 6.942 μs (4 allocations: 640 bytes)
# 709.809 ns (0 allocations: 0 bytes)
# 5.882 μs (0 allocations: 0 bytes)
# 3.713 μs (4 allocations: 1.84 KiB)
# 81.542 μs (57 allocations: 59.59 KiB)
# 11.541 μs (0 allocations: 0 bytes)
# 4.089 μs (0 allocations: 0 bytes)
# 17.000 μs (4 allocations: 1.84 KiB)
# 980.875 μs (57 allocations: 200.09 KiB)
# 807.522 ns (4 allocations: 288 bytes)
# 6.617 μs (4 allocations: 640 bytes)
# 711.307 ns (0 allocations: 0 bytes)
# 5.660 μs (0 allocations: 0 bytes)
# 29.458 μs (4 allocations: 1.84 KiB)
# 991.625 μs (57 allocations: 200.09 KiB)
for ur in (10, 100, 1000, 10000)

    seed!(20241021)

    i1_ = rand(0:9, ur)

    i2_ = rand(0:9, ur)

    f1_ = randn(ur)

    f2_ = randn(ur)

    ci = cor(i1_, i2_)

    cf = cor(f1_, f2_)

    ji = Omics.MutualInformation._get_density(i1_, i2_, ci)

    jf = Omics.MutualInformation._get_density(f1_, f2_, cf)

    #@btime cor($i1_, $i2_)

    #@btime cor($f1_, $f2_)

    #@btime Omics.MutualInformation._get_density($i1_, $i2_, $ci)

    #@btime Omics.MutualInformation._get_density($f1_, $f2_, $cf)

    #@btime Omics.MutualInformation.get_mutual_information($ji)

    #@btime Omics.MutualInformation.get_mutual_information($jf)

    #@btime Omics.MutualInformation.get_mutual_information($ji, false)

    #@btime Omics.MutualInformation.get_mutual_information($jf, false)

    #@btime Omics.MutualInformation.get_information_coefficient($i1_, $i2_)

    #@btime Omics.MutualInformation.get_information_coefficient($f1_, $f2_)

end

# ---- #

function Omics.Entropy.ge(pr)

    iszero(pr) ? 0.0 : -pr * log(pr)

end

# ---- #

function Omics.Information.get_kullback_leibler_divergence(n1, n2)

    n1 * log(n1 / n2)

end

# ---- #

# https://cdanielaam.medium.com/how-to-compare-and-evaluate-unsupervised-clustering-methods-84f3617e3769

const RE = 1.5534700710552343

for jo in (
    [
        0.2 0 0 0 0
        0 0.2 0 0 0
        0.001 0 0.199 0 0
        0.002 0 0 0.198 0
        0.006 0.002 0 0 0.192
    ],
    [
        0.2 0 0 0 0
        0.001 0 0.199 0 0
        0.006 0.002 0 0 0.192
        0.002 0 0 0.198 0
        0 0.2 0 0 0
    ],
)

    @test Omics.MutualInformation.get_mutual_information(jo) === RE

    @test isapprox(Omics.MutualInformation.get_mutual_information(jo, false), RE)

    @test isapprox(
        Omics.MutualInformation.get_mutual_information(jo, true),
        0.9653404496537963,
    )

end

# ---- #

# 469.173 ns (6 allocations: 1.00 KiB)
# 175.484 ns (4 allocations: 1.41 KiB)
# 216.587 ns (4 allocations: 272 bytes)
# 239.508 ns (0 allocations: 0 bytes)
# 801.978 ns (6 allocations: 1.23 KiB)
# 320.763 ns (4 allocations: 1.84 KiB)
# 531.634 ns (4 allocations: 288 bytes)
# 505.611 ns (0 allocations: 0 bytes)
# 2.495 μs (6 allocations: 1.23 KiB)
# 1.829 μs (4 allocations: 1.84 KiB)
# 744.381 ns (4 allocations: 288 bytes)
# 662.756 ns (0 allocations: 0 bytes)
# 17.791 μs (6 allocations: 1.23 KiB)
# 17.125 μs (4 allocations: 1.84 KiB)
# 712.468 ns (4 allocations: 288 bytes)
# 664.044 ns (0 allocations: 0 bytes)
for ur in (10, 100, 1000, 10000)

    seed!(20240903)

    i1_ = rand(0:9, ur)

    i2_ = rand(0:9, ur)

    re = mutualinfo(i1_, i2_; normed = false)

    jo = Omics.Normalization.normalize_with_sum!(
        Omics.MutualInformation._get_density(i1_, i2_, NaN),
    )

    @test isapprox(Omics.MutualInformation.get_mutual_information(jo), re)

    @test isapprox(Omics.MutualInformation.get_mutual_information(jo, false), re)

    @test isapprox(
        Omics.MutualInformation.get_mutual_information(jo, true),
        mutualinfo(i1_, i2_),
    )

    #@btime mutualinfo($i1_, $i2_; normed = false)

    #@btime Omics.Normalization.normalize_with_sum!(
    #    Omics.MutualInformation._get_density($i1_, $i2_, NaN),
    #)

    #@btime Omics.MutualInformation.get_mutual_information($jo)

    #@btime Omics.MutualInformation.get_mutual_information($jo, false)

end
