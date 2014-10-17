open NetKAT.Std

let count = ref 0

let inc_c (c: int ref) = c.contents <- c.contents + 1

let counting_hub : policy =
    <:netkat<
        if port = 1 then port := 2 + port := 3 + port := 4 + port := 5 + port := 6
        else if port = 2 then port := 1 + port := 3 + port := 4 + port := 5 + port := 6
        else if port = 3 then port := 1 + port := 2 + port := 4 + port := 5 + port := 6
        else if port = 4 then port := 1 + port := 2 + port := 3 + port := 5 + port := 6
        else if port = 5 then port := 1 + port := 2 + port := 3 + port := 4 + port := 6
        else if port = 6 then port := 1 + port := 2 + port := 3 + port := 4 + port := 6
        else drop
    >>

let _ = run_static counting_hub
