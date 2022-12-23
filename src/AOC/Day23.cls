Class AOC.Day23 Extends AOC.Base
{

Method Part1() As %Integer
{
    set result = 0

    set maxX = 0
    set maxY = 0

    set y = 0
    while ('..TestFile.AtEnd) {
        set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        for x=0:1:len {
            set tile = $EXTRACT(line,x + 1)
            set map(x,y) = tile
            if (tile = "#") {
                set elves = $GET(elves) + 1
                set elves(elves,"P") = $LISTBUILD(x,y)
                if (y > maxY) { set maxY = y }
                if (x > maxX) { set maxX = x }
            }
        }
        set y = y + 1
    }

    set dirs = "NSWE"

    for turn=1:1:2 {
        
        kill prop

        for elve=1:1:elves {
            set position = elves(elve,"P")
            set ex = $LIST(position,1)
            set ey = $LIST(position,2)

            set canMove = 0
            set i = 1
            while ('canMove && (i<5))
            {
                set ndir = $EXTRACT(dirs,i)
                set move = ..CanMove(.map,ex,ey,ndir)            
                if (move '= "") { set canMove = 1 }
                set i = i + 1
            }
            w dirs,!

            if (canMove) {
                set prop($LIST(move,1)_","_$LIST(move,2)) = $GET(prop($LIST(move,1)_","_$LIST(move,2))) + 1
                set elves(elve,"N") = $LISTBUILD($LIST(move,1),$LIST(move,2))
            }
        }
        
        for elve=1:1:elves {
            if $DATA(elves(elve,"N")) {
                set next = elves(elve,"N")
                set pos = elves(elve,"P")

                set idx = $LIST(next,1)_","_$LIST(next,2)
                if (prop(idx) = 1) {
                    set elves(elve,"P") = next
                    set map($LIST(pos,1),$LIST(pos,2)) = "."
                    set map($LIST(next,1),$LIST(next,2)) = "#"

                }
                kill elves(elve,"N")
            }
        }

        //do ..Display(.map,15,15)

        set dirs = $EXTRACT(dirs,2,*)_$EXTRACT(dirs,1)
    }

    set maxX = 0
    set maxY = 0
    set minX = 9999999999
    set minY = 9999999999
    for elve=1:1:elves {
        set pos = elves(elve,"P")
        set x = $LIST(pos,1)
        set y = $LIST(pos,2)
        if (x > maxX) { set maxX = x }
        if (y > maxY) { set maxY = y }
        if (x < minX) { set minX = x }
        if (y < minY) { set minY = y }
    }

    set result = (maxY - minY) * (maxX - minY ) 
    do ..Display(.map,15,15)
    Return result
}

Method Display(map, maxX, maxY)
{
    for y=-maxY:1:maxY{
        for x=-maxX:1:maxX {
            if $DATA(map(x,y)){
                write map(x,y)
            }
            else { write "." }
        }
        write !
    }
    write !
}

Method NextDir(curDir)
{
    set ndir = curDir
    if (curDir = "N") { set ndir = "S" }
        elseif (curDir = "S") { set ndir = "W" }
        elseif (curDir = "W") { set ndir = "E" }
        else { set ndir = "N" }
        Return ndir
}

Method CanMove(map, ex, ey, dir)
{
    set dx = 0
    set dy = -1
    set cx1 = -1
    set cx2 = 1
    set cy1 = -1
    set cy2 = -1
    if (dir = "S") {
        set dx = 0
        set dy = 1
        set cx1 = -1
        set cx2 = 1
        set cy1 = 1
        set cy2 = 1
    }
    elseif (dir = "E") {
        set dx = 1
        set dy = 0
        set cx1 = 1
        set cx2 = 1
        set cy1 = -1
        set cy2 = 1
    }
    elseif (dir = "W") {
        set dx = -1
        set dy = 0
        set cx1 = -1
        set cx2 = -1
        set cy1 = -1
        set cy2 = 1
    }

    set canMove = 1
    if ($DATA(map(ex + dx,ey + dy))) {
        if ((map(ex + dx, ey + dy) = "#")) {
            set canMove = 0
        }
    }

    if (canMove && ($DATA(map(ex + cx1,ey + cy1)))) {
        if ((map(ex + cx1,ey + cy1) = "#")) {
            set canMove = 0
        }
    }

    if (canMove && ($DATA(map(ex + cx2,ey + cy2)))) {
        if ((map(ex + cx2,ey + cy2) = "#")) {
            set canMove = 0
        }
    }

    if canMove {
        set result = $LISTBUILD(ex + dx,ey + dy)
    }
    else {
        set result = ""
    }
    Return result
}

}
