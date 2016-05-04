{
    original = root "/" $1
    files[original] = original ".tmp"

    print original 

    for (i = 2; i < NF+1; i++)  {
        split($i, field, "=")
        print "\t" field[1] " => " field[2]
        replacements[field[1]] = field[2]
    }

    while ((getline line < original) > 0) {
        for (key in replacements) {
            gsub(key, replacements[key], line)
        }
        print line > files[original]
    }
}

END {
    for (orig in files) {
        system("mv " files[orig] " " orig)
    }
}
