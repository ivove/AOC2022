Class AOC.Day16 Extends AOC.Base
{

Method Part1() As %Integer
{
    set result = 0
    kill ^||pos

    set todo = "|"
    while ('..TestFile.AtEnd) {
        set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        set currentValve = $PIECE(line," ",2)
        set rate = $PIECE($PIECE(line," ",5),"=",2)
        if (rate > 0) { set todo = todo_currentValve_"|" }
        set path = $TRANSLATE($PIECE(line," valves ",2)," ","")
        if path = "" { set path = $TRANSLATE($PIECE(line," valve ",2)," ","") }
        set len = $LENGTH(path,",")
        for i=1:1:len {
            set paths(currentValve,$PIECE(path,",",i)) = ""
        }
    }

    set start = "AA"
    do ..Go(start,"",.paths,todo)

    w todo,!
    zw ^||pos

    Return result
}

Method Go(current, path, paths, todo)
{
    w current,*9,path,*9,todo,!
    if ($LENGTH($TRANSLATE(todo,"|")) = 0) {
        set ^||pos = $GET(^||pos) + 1
        set ^||pos(^||pos) = path
    }
    else {
        set npath = path_current_","
        set ntodo = todo
        set istodo = 0
        if (todo [ ("|"_current_"|")) {
            set ntodo = $REPLACE(todo,("|"_current_"|"),"|")
            set istodo = 1
        }
        set next = $ORDER(paths(current,""))
        while next '= "" {
            if ('(path[next) || istodo) {
                do ..Go(next,npath,.paths,ntodo)
            }
            set next = $ORDER(paths(current,next))
        }
    }
}

}
