function format(nu)

    if nu == -0

        nu = 0

    end

    @sprintf("%.4g", nu)

end
