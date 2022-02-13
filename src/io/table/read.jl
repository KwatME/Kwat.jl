function read(pa; xl = "")

    if !ispath(pa)

        error(pa, " does not exist.")

    end

    ex = splitext(pa)[2]

    if ex == ".xlsx"

        return DataFrame(readtable(pa, xl)...)

    else

        it_ = mmap(pa)

        if ex == ".gz"

            it_ = transcode(GzipDecompressor, it_)

        end

        return CSV_read(it_, DataFrame)

    end

end
