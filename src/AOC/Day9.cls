Class AOC.Day9 Extends AOC.Base
{

Method Part1()
{
    set result = 0
    set hx = 0
    set hy = 0
    set tx = 0
    set ty = 0
    while ('..File.AtEnd) {
        set line = ..File.ReadLine()
        set dir = $PIECE(line," ")
        set steps = $PIECE(line," ",2)

        set deltaX = 0
        set deltaY = 0
        if (dir = "R") { set deltaX = 1 }
        if (dir = "L") { set deltaX = -1 }
        if (dir = "D") { set deltaY = -1 }
        if (dir = "U") { set deltaY = 1 }

        set visited("0|0") = 1
        
        for i=1:1:steps {
            //set visited(tx_"|"_ty) = $GET(visited(tx_"|"_ty)) + 1

            set hx = hx + deltaX
            set hy = hy + deltaY

            set diffX = $ZABS(hx - tx)
            set diffY = $ZABS(hy - ty)
            
            if ('((diffX <= 1) && (diffY <= 1))) {
                //set result = result + 1
                set dx = 0
                set dy = 0
                if (hx > tx) { set dx = 1 }
                if (hx < tx) { set dx = -1 }
                if (hy > ty) { set dy = 1 }
                if (hy < ty) { set dy = -1}
                set tx = tx + dx
                set ty = ty + dy
                set visited(tx_"|"_ty) = $GET(visited(tx_"|"_ty)) + 1
            }
        }
    }
    
    set maxX = 0
    set maxY = 0
    set coord = $ORDER(visited(""))
    while (coord '= "") {
        set result = result + 1 //$GET(visited(coord))
        set x = $PIECE(coord,"|")
        set y = $PIECE(coord,"|",2)
        if (x > maxX) { set maxX = x }
        if (y > maxY) { set maxY = y }
        set coord = $ORDER(visited(coord))
    }
    /*
    for y=0:1:maxY {
        for x=0:1:maxX {
            if $DATA(visited(x_"|"_y)) { w "#" }
            else { w "." }
        }
        w !
    }
    */
    Return result
}

Method Part2()
{
    set result = 0
    set t(0,"x") = 0
    set t(0,"y") = 0
    set t(1,"x") = 0
    set t(1,"y") = 0
    set t(2,"x") = 0
    set t(2,"y") = 0
    set t(3,"x") = 0
    set t(3,"y") = 0
    set t(4,"x") = 0
    set t(4,"y") = 0
    set t(5,"x") = 0
    set t(5,"y") = 0
    set t(6,"x") = 0
    set t(6,"y") = 0
    set t(7,"x") = 0
    set t(7,"y") = 0
    set t(8,"x") = 0
    set t(8,"y") = 0
    set t(9,"x") = 0
    set t(9,"y") = 0
    
    set visited("0|0") = 1

    while ('..File.AtEnd) {
        set line = ..File.ReadLine()
        set dir = $PIECE(line," ")
        set steps = $PIECE(line," ",2)

        set deltaX = 0
        set deltaY = 0
        if (dir = "R") { set deltaX = 1 }
        if (dir = "L") { set deltaX = -1 }
        if (dir = "D") { set deltaY = -1 }
        if (dir = "U") { set deltaY = 1 }
        
        for i=1:1:steps {

            set t(0,"x") = t(0,"x") + deltaX
            set t(0,"y") = t(0,"y") + deltaY

            for k=1:1:9
            {
                set diffX = $ZABS(t(k-1,"x") - t(k,"x"))
                set diffY = $ZABS(t(k-1,"y") - t(k,"y"))

                if ('((diffX <= 1) && (diffY <= 1))) {
                    set dx = 0
                    set dy = 0
                    if (t(k-1,"x") > t(k,"x")) { set dx = 1 }
                    if (t(k-1,"x") < t(k,"x")) { set dx = -1 }
                    if (t(k-1,"y") > t(k,"y")) { set dy = 1 }
                    if (t(k-1,"y") < t(k,"y")) { set dy = -1}
                    set t(k,"x") = t(k,"x") + dx
                    set t(k,"y") = t(k,"y") + dy
                    if (k = 9) { set visited(t(9,"x")_"|"_t(9,"y")) = "" } //$GET(visited(tx_"|"_ty)) + 1 }
                }
            }
        }
    }
    zw t
    set maxX = 0
    set maxY = 0
    set coord = $ORDER(visited(""))
    while (coord '= "") {
        set result = result + 1 //$GET(visited(coord))
        set x = $PIECE(coord,"|")
        set y = $PIECE(coord,"|",2)
        if (x > maxX) { set maxX = x }
        if (y > maxY) { set maxY = y }
        set coord = $ORDER(visited(coord))
    }
    /*
    for y=0:1:maxY {
        for x=0:1:maxX {
            if $DATA(visited(x_"|"_y)) { w "#" }
            else { w "." }
        }
        w !
    }
    */
    Return result
}

}
