Class AOC.Day14 Extends AOC.Base
{

Method Part1() As %Integer
{
    set result = 0
    set maxY = 0

    while ('..File.AtEnd) {
        set line = $TRANSLATE($TRANSLATE(..File.ReadLine(),$CHAR(13),"")," ","")
        set len = $LENGTH(line,"->")
        for i=1:1:(len - 1) {
            set from = $PIECE(line,"->",i)
            set to = $PIECE(line,"->",i+1)

            set fromX = $PIECE(from,",")
            set fromY = $PIECE(from,",",2)
            set toX = $PIECE(to,",")
            set toY = $PIECE(to,",",2)

            set xDir = fromX
            if (toX < fromX) { 
                set fromX = toX
                set toX = xDir
            }
            set yDir = fromY
            if (toY < fromY) {
                set fromY = toY 
                set toY = yDir
            }

            set x = fromX
            while (x <= toX) {
                set y = fromY
                while (y <= toY) {
                    set map(x,y) = "#"
                    if (y > maxY) { set maxY = y }
                    set y = y + 1
                }
                set x = x + 1
            }
        }
    }

    set cont = 1
    set sand = 0
    set spawnX = 500
    set spawnY = 0
    while (cont) {        
        //do ..Draw(.map,494,503,0,10)
        
        set x = spawnX
        set y = spawnY

        set blocked = 0
        set sand = sand + 1
        while ('blocked && (y <= maxY)) {
            if ($DATA(map(x,y+1)) && ($DATA(map(x-1,y+1))) && ($DATA(map(x+1,y+1)))) {
                set blocked = 1
                set map(x,y) = "0"
            }
            elseif ($DATA(map(x,y+1)) && '$DATA(map(x-1,y+1))) {
                set x = x - 1
                set y = y + 1
            }
            elseif ($DATA(map(x,y+1)) && '$DATA(map(x+1,y+1))) {
                set x = x + 1
                set y = y + 1
            }
            else { set y = y + 1 }
        }
        if (y > maxY) { set cont = 0 }
    }

    set result = sand - 1
    //do ..Draw(.map,494,503,0,10)

    Return result
}

Method Draw(map, fromX, toX, fromY, toY)
{
    for y=fromY:1:toY {
        for x= fromX:1:toX {
            if $DATA(map(x,y)) { write map(x,y) }
            else { write "." }
        }
        write !
    }
    write !
}

Method Part2() As %Integer
{
    set result = 0
    set maxY = 0

    while ('..File.AtEnd) {
        set line = $TRANSLATE($TRANSLATE(..File.ReadLine(),$CHAR(13),"")," ","")
        set len = $LENGTH(line,"->")
        for i=1:1:(len - 1) {
            set from = $PIECE(line,"->",i)
            set to = $PIECE(line,"->",i+1)

            set fromX = $PIECE(from,",")
            set fromY = $PIECE(from,",",2)
            set toX = $PIECE(to,",")
            set toY = $PIECE(to,",",2)

            set xDir = fromX
            if (toX < fromX) { 
                set fromX = toX
                set toX = xDir
            }
            set yDir = fromY
            if (toY < fromY) {
                set fromY = toY 
                set toY = yDir
            }

            set x = fromX
            while (x <= toX) {
                set y = fromY
                while (y <= toY) {
                    set map(x,y) = "#"
                    if (y > maxY) { set maxY = y }
                    set y = y + 1
                }
                set x = x + 1
            }
        }
    }

    set cont = 1
    set sand = 0
    set spawnX = 500
    set spawnY = 0
    while (cont) {        
        //do ..Draw(.map,486,516,0,12)
        
        set x = spawnX
        set y = spawnY

        set blocked = 0
        set sand = sand + 1
        while ('blocked) {
            if ((y + 1) > (maxY + 1)) { 
                set blocked = 1 
                set map(x,y) = "0"
            }
            elseif ($DATA(map(x,y+1)) && ($DATA(map(x-1,y+1))) && ($DATA(map(x+1,y+1)))) {
                set blocked = 1
                set map(x,y) = "0"
            }
            elseif ($DATA(map(x,y+1)) && '$DATA(map(x-1,y+1))) {
                set x = x - 1
                set y = y + 1
            }
            elseif ($DATA(map(x,y+1)) && '$DATA(map(x+1,y+1))) {
                set x = x + 1
                set y = y + 1
            }
            else { set y = y + 1 }
        }
        if ((y = spawnY) && (x = spawnX)) { set cont = 0 }
        //if sand > 26 set cont = 0
    }

    set result = sand
    //do ..Draw(.map,486,516,0,12)
    Return result
}

}
