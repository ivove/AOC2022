Class AOC.Day12 Extends AOC.Base
{

Method Part1() As %Integer
{
        set result = 0
        set start = "0,0"
        set end = "0,0"
        set y = 1
        while ('..TestFile.AtEnd) {
            set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
            set len = $LENGTH(line)
            for x=1:1:len {
                set tile = $EXTRACT(line,x)
                if (tile = "S") { 
                    set start = x_","_y 
                    set tile = "a"
                }
                if (tile = "E") {
                    set end = x_","_y
                    set tile = "z"
                }
                set tile = $ASCII(tile)
                set map(x,y) = tile
            }
            set y = y + 1
        }

        set x = $ORDER(map(""))
        while (x '= "") {
            set y = $ORDER(map(x,""),1,h)
            while (y '= "") {
                set nx = x - 1
                set nh = $GET(map(nx,y),"")
                if ((nh '= "") && (nh <= (h + 1))) {
                    set pos(x_","_y,nx_","_y) = ""
                }
                set nx = x + 1
                set nh = $GET(map(nx,y),"")
                if ((nh '= "") && (nh <= (h + 1))) {
                    set pos(x_","_y,nx_","_y) = ""
                }

                set ny = y - 1
                set nh = $GET(map(x,ny),"")
                if ((nh '= "") && (nh <= (h + 1))) {
                    set pos(x_","_y,x_","_ny) = ""
                }
                set ny = y + 1
                set nh = $GET(map(x,ny),"")
                if ((nh '= "") && (nh <= (h + 1))) {
                    set pos(x_","_y,x_","_ny) = ""
                }
                set y = $ORDER(map(x,y),1,h)
            }
            set x = $ORDER(map(x))
        }

        set open(..CalcH(start,end),start) = ""
        set dist(start) = 0
        set found = 0
        while ('found) {
            set h = $ORDER(open(""))
            set current = $ORDER(open(h,""))
            w !,current,*9,$GET(dist(current))
            if (current = end) {
                set found = 1
            }
            else {
                set closed(current) = ""
                kill open(h,current)
                set next = $ORDER(pos(current,""))
                while (next '= "") {
                    if ('$DATA(open(..CalcH(next,end),next)) && '$DATA(closed(next))) {
                        set open(..CalcH(next,end),next) = ""
                        set dist(next) = dist(current) + 1
                    } elseif ($DATA(closed(next)) && (dist(next) > (dist(current) + 1))) {
                        set dist(next) = dist(current) + 1
                    } elseif ('$DATA(closed(next))) {
                        set open(..CalcH(next,end),next) = ""
                    }
                    set next = $ORDER(pos(current,next))
                }
            }
        }
        /*
        do ..Go(start,"|",.pos,end,.results)

        set min = 9999999999
        for p=1:1:results {
            set path = results(p)
            set len = $LENGTH(path,"|") - 2
            if (len < min) { set min = len }
        }
        set result = min 
        */
        set result = dist(end)
        w !
        Return result
}

Method CalcH(from, to) As %Integer
{
    set x = $PIECE(from,",")
    set y = $PIECE(from,",",2)
    set tx = $PIECE(to,",")
    set ty = $PIECE(to,",",2)
    Return $ZABS(x-tx) + $ZABS(y-ty)
}

Method Go(start, path, pos, end, results)
{
    if (start = end) {
        set path = path_start
        set results = $GET(results) + 1
        set results(results) = path
    }
    else {
        set npath = path_start_"|"
        set next = $ORDER(pos(start,""))
        while (next '= "") {
            if (path '[ ("|"_next_"|")) {
                do ..Go(next,npath,.pos,end,.results)
            }
            set next = $ORDER(pos(start,next))
        }
    }
}

}
