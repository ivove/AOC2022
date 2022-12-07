Class AOC.Day7 Extends AOC.Base
{

Method Part1() As %Integer
{
        set result = 0
        set currentDir = " "
        set parentDir = " "
        while ('..File.AtEnd) {
            set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            if ($EXTRACT(line,1) = "$") {
                set cmd = $PIECE(line," ",2)
                if (cmd = "cd") {
                    set dir = $PIECE(line," ",3)
                    if (dir '= "..") {
                        set parentDir = currentDir
                        set currentDir = parentDir_"\"_dir
                        set map(currentDir)= parentDir
                    }
                    else {

                        set parentDir = map(currentDir)
                        set currentDir = parentDir
                    }
                }
            }
            else {
                set p1 = $PIECE(line," ")
                set p2 = $PIECE(line," ",2)
                if (p1 '= "dir") {
                    set content(currentDir,p2) = p1
                    set size(currentDir) = $GET(size(currentDir)) + p1
                    d ..AddSize(parentDir,.map,.size,p1)
                }
            }
        }

        set dir = $ORDER(size(" "),1,val)
        while (dir '= "") {
            if (val <= 100000) { set result = result + val }
            set dir = $ORDER(size(dir),1,val)
        }

        return result
}

Method Part2() As %Integer
{
        set result = 0
        set currentDir = " "
        set parentDir = " "
        while ('..File.AtEnd) {
            set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            if ($EXTRACT(line,1) = "$") {
                set cmd = $PIECE(line," ",2)
                if (cmd = "cd") {
                    set dir = $PIECE(line," ",3)
                    if (dir '= "..") {
                        set parentDir = currentDir
                        set currentDir = parentDir_"\"_dir
                        set map(currentDir)= parentDir
                    }
                    else {

                        set parentDir = map(currentDir)
                        set currentDir = parentDir
                    }
                }
            }
            else {
                set p1 = $PIECE(line," ")
                set p2 = $PIECE(line," ",2)
                if (p1 '= "dir") {
                    set content(currentDir,p2) = p1
                    set size(currentDir) = $GET(size(currentDir)) + p1
                    d ..AddSize(parentDir,.map,.size,p1)
                }
            }
        }

        set totalSize = 70000000
        set freeSpace = totalSize - size(" ")
        set neededSize = 30000000 - freeSpace        

        set dir = $ORDER(size(" "),1,val)
        while (dir '= "") {
            if (val >= neededSize) { set pos(val,dir) = "" }
            set dir = $ORDER(size(dir),1,val)
        }

        set min = $ORDER(pos(""))

        return min
}

Method AddSize(current, map, size, add)
{
    s size(current) = $GET(size(current)) + add
    if ($DATA(map(current))){
        set p = map(current)
        d ..AddSize(p,.map,.size,add)
    }
}

}
