function get_common_start(an__)

    le_ = [length(an_) for an_ in an__]

    mi = minimum(le_)

    sh = an__[findfirst(le == mi for le in le_)]

    id = 1

    # TODO: Speed up.
    while id <= mi

        an = sh[id]

        if any(an_[id] != an for an_ in an__)

            break

        end

        id += 1

    end

    sh[1:(id - 1)]

end
