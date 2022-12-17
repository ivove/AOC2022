Class AOC.Day15 Extends AOC.Base
{

Method Part1(checkY As %Integer) As %Integer
{
    set result = 0
    
    while ('..File.AtEnd) {
        set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set sensors = $GET(sensors) + 1

        //Sensor at x=2, y=18: closest beacon is at x=-2, y=15
        set sensor = $PIECE(line,":")
        set sX = $TRANSLATE($PIECE($PIECE(sensor," ",3),"=",2),",","")
        set sY = $PIECE($PIECE(sensor," ",4),"=",2)
        set beacon = $PIECE(line,":",2)
        set bX = $TRANSLATE($PIECE($PIECE(beacon," ",6),"=",2),",","")
        set bY = $PIECE($PIECE(beacon," ",7),"=",2)

        set sensors(sX,sY) = $LISTBUILD(bX,bY)
    }

    set minx = 9999999999
    set maxx = -9999999999
    set x = $ORDER(sensors(""))
    while (x '= "") {
        set y = $ORDER(sensors(x,""),1,beacon)
        while (y '= "") {
            set map(y,x) = "S"
            set map($LIST(beacon,2),$LIST(beacon,1)) = "B"
            set dist = $ZABS((x - $LIST(beacon,1))) + $ZABS((y - $LIST(beacon,2)))
            if ((x - dist) < minx) { set minx = (x - dist) }
            if ((x + dist) > maxx) { set maxx = (x + dist) }
            set y = $ORDER(sensors(x,y),1,beacon)
        }
        set x = $ORDER(sensors(x))
    }

    for tx=minx:1:maxx {
        if ('$DATA(map(checkY,tx))) {
            set fnd = 0
            set x = $ORDER(sensors(""))
            while ('fnd && (x '= "")) {
                set y = $ORDER(sensors(x,""),1,beacon)
                while ('fnd && (y '= "")) {
                    set bdst = $ZABS(x - $LIST(beacon,1)) + $ZABS(y - $LIST(beacon,2))
                    set tdxt = $ZABS(x - tx) + $ZABS(y - checkY)
                    if (tdxt <= bdst) { set fnd = 1 }
                    set y = $ORDER(sensors(x,y),1,beacon)
                }
                set x= $ORDER(sensors(x))
            }
            if (fnd) { set result = result + 1 }
        }
    }
    
    Return result
}

Method Part2(max As %Integer) As %Integer
{
    set result = 0
    
    while ('..TestFile.AtEnd) {
        set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        set sensors = $GET(sensors) + 1

        //Sensor at x=2, y=18: closest beacon is at x=-2, y=15
        set sensor = $PIECE(line,":")
        set sX = $TRANSLATE($PIECE($PIECE(sensor," ",3),"=",2),",","")
        set sY = $PIECE($PIECE(sensor," ",4),"=",2)
        set beacon = $PIECE(line,":",2)
        set bX = $TRANSLATE($PIECE($PIECE(beacon," ",6),"=",2),",","")
        set bY = $PIECE($PIECE(beacon," ",7),"=",2)

        set sensors(sX,sY) = $LISTBUILD(bX,bY)
    }

    set minx = 9999999999
    set maxx = -9999999999
    set x = $ORDER(sensors(""))
    while (x '= "") {
        set y = $ORDER(sensors(x,""),1,beacon)
        while (y '= "") {
            set map(y,x) = "S"
            set map($LIST(beacon,2),$LIST(beacon,1)) = "B"
            set dist = $ZABS((x - $LIST(beacon,1))) + $ZABS((y - $LIST(beacon,2)))
            if ((x - dist) < minx) { set minx = (x - dist) }
            if ((x + dist) > maxx) { set maxx = (x + dist) }
            set y = $ORDER(sensors(x,y),1,beacon)
        }
        set x = $ORDER(sensors(x))
    }

    set freeX = 0
    set freeY = 0
    for y=0:1:max {
        for x=0:1:max {
            set fnd = 0
            if ('$DATA(map(y,x))) {
                set sx = $ORDER(sensors(""))
                while ('fnd && (sx '= "")) {
                    set sy = $ORDER(sensors(x,""),1,beacon)
                    while ('fnd && (sy '= "")) {
                        set bdst = $ZABS(sx - $LIST(beacon,1)) + $ZABS(sy - $LIST(beacon,2))
                        set tdxt = $ZABS(x - sx) + $ZABS(y - sy)
                        if (tdxt > bdst) { 
                            set fnd = 1 
                            set freeX = x
                            set freeY = y       
                            //write "found",*9,x,*9,y,!
                        }
                        set sy = $ORDER(sensors(sx,sy),1,beacon)
                    }
                    set sx = $ORDER(sensors(sx))
                }
                    i fnd { w "#" }
                    else { w "." }
            }
            else { w map(y,x) }
        }
        w !
    }
    w freeX,*9,freeY,!
    Return ((freeX * 4000000) + freeY)
}

}
