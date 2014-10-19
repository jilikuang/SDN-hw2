open NetKAT.Std

let flood : policy =
    <:netkat<
        if port = 1 then port := 2 + port := 3 + port := 4
        else if port = 2 then port := 1 + port := 3 + port := 4
        else if port = 3 then port := 1 + port := 2 + port := 4
        else if port = 4 then port := 1 + port := 2 + port := 3
        else drop
    >>

let switch : policy =
    <:netkat<
        if ethSrc = 1
           && ethType = 0x0800 && ipProto = 0x06 && tcpDstPort = 22 &&
           (ethDst = 3 || ethDst = 4)
        then drop
        else $flood
    >>

let _ = run_static switch
