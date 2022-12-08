Class AOC.Day8 Extends AOC.Base
{

Method Part1()
{
    set result = 0
    set y = 1
    set maxY = 1
    set maxX = 1
    while ('..File.AtEnd){
        set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        set maxX = len
        set maxY = maxY + 1
        for x=1:1:len {
            set tree = $EXTRACT(line,x)
            set map(x,y) = tree
            set imap(y,x) = tree
        }
        set y = y + 1
    }
    set x = $ORDER(map(""))
    while (x '= "") {
        set high = -1
        set y = $ORDER(map(x,""),1,tree)
        while (y '= "") {
            if (tree > high) { 
                set high = tree
                set vis(x_"-"_y) = "" 
            }
            set y = $ORDER(map(x,y),1,tree)
        }
        set high = -1
        set y = $ORDER(map(x,""),-1,tree)
        while (y '= "") {
            if (tree > high) { 
                set high = tree
                set vis(x_"-"_y) = "" 
            }
            set y = $ORDER(map(x,y),-1,tree)
        }
        set x = $ORDER(map(x))
    }
    set y = $ORDER(imap(""))
    while(y '= "") { 
        set high = -1
        set x = $ORDER(imap(y,""),1,tree)
        while (x '= "") {
            if (tree > high) { 
                set high = tree
                set vis(x_"-"_y) = "" 
            }
            set x = $ORDER(imap(y,x),1,tree)
        }
        set high = -1
        set x = $ORDER(imap(y,""),-1,tree)
        while (x '= "") {
            if (tree > high) { 
                set high = tree
                set vis(x_"-"_y) = "" 
            }
            set x = $ORDER(imap(y,x),-1,tree)
        }
        set y = $ORDER(imap(y))
    }
    set coord = $ORDER(vis(""))
    while (coord '= "") {
        set result = result + 1
        set coord = $ORDER(vis(coord))
    }

    return result
}

Method Part2()
{
    set result = 0
    set y = 1
    set maxY = 1
    set maxX = 1
    while ('..File.AtEnd){
        set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        set maxX = len
        set maxY = maxY + 1
        for x=1:1:len {
            set tree = $EXTRACT(line,x)
            set map(x,y) = tree
            set imap(y,x) = tree
        }
        set y = y + 1
    }
    set maxScore = 0
    set x = $ORDER(map(""))
    while (x '= "") {
        set y = $ORDER(map(x,""))
        while (y '= "") {
            set score = ..getScenicScore(x,y,map(x,y),.map,.imap)
            if (score > maxScore) { set maxScore = score }
            set y = $ORDER(map(x,y))
        }
        set x = $ORDER(map(x))
    }

    return maxScore
}

Method getScenicScore(x, y, tree, map, imap)
{
    set score = 0
    set s1 = 0
    set cont = 1
    set tx = $ORDER(map(x))
    while ((tx '= "") && cont) {        
        if (map(tx,y) < tree) {
            set s1 = s1 + 1
        }
        else {
            set s1 = s1 + 1 
            set cont = 0
        }
        set tx = $ORDER(map(tx))
    }  
    set s2 = 0
    set cont = 1
    set tx = $ORDER(map(x),-1)
    while ((tx '= "") && cont) {
        if (map(tx,y) < tree) {
            set s2 = s2 + 1
        }
        else {
            set s2 = s2 + 1
            set cont = 0
        }

        set tx = $ORDER(map(tx),-1)
    } 

    set s3 = 0
    set cont = 1
    set ty = $ORDER(imap(y))
    while ((ty '= "") && cont) {
        if (map(x,ty) < tree) {
            set s3 = s3 + 1
        }
        else {
            set s3 = s3 + 1
            set cont = 0
        }

        set ty = $ORDER(imap(ty))
    }
    set s4 = 0
    set cont = 1
    set ty = $ORDER(imap(y),-1)
    while ((ty '= "") && cont) {
        if (map(x,ty) < tree) {
            set s4 = s4 + 1
        }
        else {
            set s4 = s4 + 1
            set cont = 0
        }

        set ty = $ORDER(imap(ty),-1)
    }
    

    set score = s1 * s2 * s3 * s4
    return score
}

}
