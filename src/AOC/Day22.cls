Class AOC.Day22 Extends AOC.Base
{

Method Part1() As %Integer
{
    set result = 0
    set mapping = 1
    set facing = "R"
    set currentX = ""
    set currentY = ""
    set y = 0
    while ('..File.AtEnd){
        set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")

        if (line = "") { set mapping = 0 }
        
        if (mapping) {
            set len =$LENGTH(line)
            for x=1:1:len {
                set tile = $EXTRACT(line,x)
                if ((currentX = "") && (tile = ".")) {
                    set currentX = x-1
                    set currentY = y
                }
                set map(x-1,y) = tile
                set max(y) = x - 1
            } 
            set y = y + 1
        }
        elseif (line '= "") {
            set instruction = line
        }
    }

    zw map

    while (instruction '= "") {
        if (instruction?1.N.E) {
            set passes  = +instruction
            set dx = 1
            set dy = 0
            if (facing = "L") {
                set dx = -1
                set dy = 0
            }
            elseif (facing = "U") {
                set dx = 0
                set dy = -1
            }
            elseif (facing = "D") {
                set dx = 0
                set dy = 1
            }

            for p=1:1:passes {
                set nx = currentX + dx
                set ny = currentY + dy
                if ('$DATA(map(nx,ny))) {
                    if (facing = "R") { set nx = 0 }
                    if (facing = "D") { set ny = 0 }
                    if (facing = "U") { set ny = $ORDER(map(nx,""),-1) }
                    if (facing = "L") { set nx = max(ny) }
                }

                if ((map(nx,ny) = " ") || (map(nx,ny) = "")) {
                    while((map(nx,ny) = " ") || (map(nx,ny) = "")) {
                        set nx = nx + dx
                        set ny = ny + dy
                        if ('$DATA(map(nx,ny))) {
                            if (facing = "R") { set nx = 0 }
                            if (facing = "D") { set ny = 0 }
                            if (facing = "U") { set ny = $ORDER(map(nx,""),-1) }
                            if (facing = "L") { set nx = max(ny) }
                        }
                    }
                }
                
                if (map(nx,ny) = ".") {
                    set currentX = nx
                    set currentY = ny
                }
            }

            set instruction = $EXTRACT(instruction,$LENGTH(passes)+1,*)
        }
        else {
            set turn = $EXTRACT(instruction,1)
            if (turn = "R") {
                if (facing = "R") { set facing = "D" }
                elseif (facing = "D") { set facing = "L" }
                elseif (facing = "L") { set facing = "U" }
                elseif (facing = "U") { set facing = "R" }
            }
            else {
                if (facing = "R") { set facing = "U" }
                elseif (facing = "D") { set facing = "R" }
                elseif (facing = "L") { set facing = "D" }
                elseif (facing = "U") { set facing = "L" }
            }
            set instruction = $EXTRACT(instruction,2,*)
        }
    }

    w !,currentX,*9,currentY,*9,facing,!
    set dir = 0
    if (facing = "D") { set dir = 1 }
    if (facing = "L") { set dir = 2 }
    if (facing = "U") { set dir = 3 }

    set result = ((currentY + 1) * 1000) + ((currentX + 1) * 4) + dir

    Return result
}

Method Part2() As %Integer
{
    set result = 0
    set mapping = 1
    set facing = "R"
    set currentX = ""
    set currentY = ""
    set y = 0
    while ('..File.AtEnd){
        set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")

        if (line = "") { set mapping = 0 }
        
        if (mapping) {
            set len =$LENGTH(line)
            for x=1:1:len {
                set tile = $EXTRACT(line,x)
                if ((currentX = "") && (tile = ".")) {
                    set currentX = x-1
                    set currentY = y
                }
                set map(x-1,y) = tile
                set max(y) = x - 1
            } 
            set y = y + 1
        }
        elseif (line '= "") {
            set instruction = line
        }
    }

    zw map

    while (instruction '= "") {
        if (instruction?1.N.E) {
            set passes  = +instruction
            set dx = 1
            set dy = 0
            if (facing = "L") {
                set dx = -1
                set dy = 0
            }
            elseif (facing = "U") {
                set dx = 0
                set dy = -1
            }
            elseif (facing = "D") {
                set dx = 0
                set dy = 1
            }

            for p=1:1:passes {
                set nx = currentX + dx
                set ny = currentY + dy
                if ('$DATA(map(nx,ny))) {
                    if (facing = "R") { set nx = 0 }
                    if (facing = "D") { set ny = 0 }
                    if (facing = "U") { set ny = $ORDER(map(nx,""),-1) }
                    if (facing = "L") { set nx = max(ny) }
                }

                if ((map(nx,ny) = " ") || (map(nx,ny) = "")) {
                    while((map(nx,ny) = " ") || (map(nx,ny) = "")) {
                        set nx = nx + dx
                        set ny = ny + dy
                        if ('$DATA(map(nx,ny))) {
                            if (facing = "R") { set nx = 0 }
                            if (facing = "D") { set ny = 0 }
                            if (facing = "U") { set ny = $ORDER(map(nx,""),-1) }
                            if (facing = "L") { set nx = max(ny) }
                        }
                    }
                }
                
                if (map(nx,ny) = ".") {
                    set currentX = nx
                    set currentY = ny
                }
            }

            set instruction = $EXTRACT(instruction,$LENGTH(passes)+1,*)
        }
        else {
            set turn = $EXTRACT(instruction,1)
            if (turn = "R") {
                if (facing = "R") { set facing = "D" }
                elseif (facing = "D") { set facing = "L" }
                elseif (facing = "L") { set facing = "U" }
                elseif (facing = "U") { set facing = "R" }
            }
            else {
                if (facing = "R") { set facing = "U" }
                elseif (facing = "D") { set facing = "R" }
                elseif (facing = "L") { set facing = "D" }
                elseif (facing = "U") { set facing = "L" }
            }
            set instruction = $EXTRACT(instruction,2,*)
        }
    }

    w !,currentX,*9,currentY,*9,facing,!
    set dir = 0
    if (facing = "D") { set dir = 1 }
    if (facing = "L") { set dir = 2 }
    if (facing = "U") { set dir = 3 }

    set result = ((currentY + 1) * 1000) + ((currentX + 1) * 4) + dir

    Return result
}

}
