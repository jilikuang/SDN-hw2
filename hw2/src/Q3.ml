open NetKAT.Std

let flood : policy =
    <:netkat<
        if port = 1 then port := 2 + port := 3 + port := 4
        else if port = 2 then port := 1 + port := 2 + port := 4
        else if port = 3 then port := 1 + port := 2 + port := 4
        else if port = 4 then port := 1 + port := 2 + port := 3
        else drop
    >>

let pol_h1 : policy =
    <:netkat<
        if (tcpSrcPort = 22 && (ethDst = 3 || ethDst = 4))
        then drop
        else $flood
    >>

let switch : policy =
    <:netkat<
        if ethSrc = 1 then $pol_h1
        else $flood
    >>

let _ = run_static switch
