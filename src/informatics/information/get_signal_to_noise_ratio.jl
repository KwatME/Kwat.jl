function _update(me, st)

    fa = 0.2

    lo = abs(me) * fa

    if me == 0

        me = 1

        st = fa

    elseif st < lo

        st = lo

    end

    return me, st

end

function get_signal_to_noise_ratio(ve1, ve2)

    co = false

    me1, st1 = _update(mean(ve1), std(ve1, corrected = co))

    me2, st2 = _update(mean(ve2), std(ve2, corrected = co))

    return (me2 - me1) / (st1 + st2)

end
