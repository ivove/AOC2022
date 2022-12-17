Class AOC.Day17 Extends AOC.Base
{

Method Part1(rocks As %Integer = 2023) As %Integer
{
   
    set result = 0

    set instrucions = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
    set len = $LENGTH(instrucions)
    for i=1:1:len {
        set instruction(i) = $EXTRACT(instrucions,i)
    }

    set highest = 0
    set blockType = 1
    set blockX = 0
    set blockY = 0
    set i = 1

    for s=1:1:rocks {
        if (blockType = 2) {
            // +
            
            set blockY = highest + 4
            set blockX = 4
        }
        else {
            set blockY = highest + 4
            set blockX = 3
        }

        set ended = 0
        set turn = 0
        //set i = 1
        while ('ended) {
            if ((turn#2) = 0) {
                // instruction
                set todo = instruction(i)
                //w "instruction",*9,todo,!
                set dx = 1
                if (todo = "<") { set dx = -1 }

                if (blockType = 1) {
                    if ('((blockX + dx) = 0) && '((blockX + 3 + dx) = 8)) {
                        if ('$DATA(map(blockX+dx,blockY)) && '$DATA(map(blockX + 3 + dx,blockY))) {
                            set blockX = blockX + dx
                        }
                    }
                }
                elseif (blockType = 2) {
                    if ('((blockX - 1 + dx) = 0) && '((blockX + 1 + dx) = 8)) {
                        set collision = 0
                        if ($DATA(map(blockX + dx,blockY))) {set collision = 1 }
                        elseif ($DATA(map(blockX - 1 + dx,blockY + 1))) { set collision = 1 }
                        elseif ($DATA(map(blockX + 1 + dx,blockY + 1))) { set collision = 1 }
                        elseif ($DATA(map(blockX + dx,blockY + 2))) { set collision = 1 }
                        if ('collision) { set blockX = blockX + dx }
                    }
                }
                elseif (blockType = 3) {
                    if ('((blockX + dx) = 0) && '((blockX + 2 + dx) = 8)) {
                        set collision = 0
                        for dy=1:1:2 {
                            if $DATA(map(blockX + 2 + dx,blockY + dy)) { set collision = 1 }
                        }
                        if ('collision) {
                            if ($DATA(map(blockX + dx,blockY))) { set collision = 1 }
                            elseif ($DATA(map(blockX + 2 + dx,blockY))) { set collision = 1 }
                        }
                        if ('collision) { set blockX = blockX + dx }
                    }
                }
                elseif (blockType = 4) {
                    if ('((blockX + dx) = 0) && '((blockX + dx) = 8)) {
                        set collision = 0
                        for dy=0:1:3 {
                            if ($DATA(map(blockX + dx, blockY + dy))) {
                                set collision = 1
                            }
                        }
                        if ('collision) { set blockX = blockX + dx }
                    }
                }
                else {
                    if ('((blockX + dx) = 0) && '((blockX + 1 + dx) = 8)) {
                        set collision = 0
                        for dy=0:1:1 {
                            if ($DATA(map(blockX + dx,blockY + dy))) { set collision = 1 }
                            elseif ($DATA(map(blockX + 1 + dx,blockY + dy))) { set collision = 1 }
                        }
                        if ('collision) { set blockX = blockX + dx }
                    }
                }

                set i = i + 1
                if (i > len) { set i = 1 }
            }
            else {
                // down
                //w "down",!
                //w turn,*9,s,*9,highest,*9,$GET(i),*9,len,*9,$GET(todo),!
                //do ..Display(.map,highest, blockX,blockY,blockType)
                if ((blockY - 1) = 0) { set ended = 1 }
                else {
                    if (blockType = 1) {
                        for dx=0:1:3 {
                            if ($DATA(map(blockX + dx,blockY - 1))) {
                                set ended = 1
                            }
                        }
                    }
                    elseif (blockType = 2) {
                        if $DATA(map(blockX,blockY - 1)) { set ended = 1 }
                        elseif ($DATA(map(blockX - 1,blockY))) { set ended = 1 }
                        elseif ($DATA(map(blockX + 1,blockY))) { set ended = 1 }
                    }
                    elseif (blockType = 3) {
                        for dx=0:1:2 {
                            if ($DATA(map(blockX + dx,blockY - 1))) {
                                set ended = 1
                            }
                        }
                    }
                    elseif (blockType = 4) {
                        if ($DATA(map(blockX,blockY - 1))) {
                            set ended = 1
                        }
                    }
                    else {
                        for dx=0:1:1 {
                            if ($DATA(map(blockX + dx,blockY - 1))) {
                                set ended = 1
                            }
                        }
                    }
                }

                if (ended) {
                    if (blockType = 1) {
                        for dx=0:1:3 {
                            set map(blockX + dx,blockY) = "#"
                        }
                        set nh = blockY
                        if (nh > highest) { set highest = nh }
                    }
                    elseif (blockType = 2) {
                        set map(blockX,blockY) = "#"
                        set map(blockX, blockY + 2) = "#"
                        for dx=-1:1:1 {
                            set map(blockX + dx,blockY + 1) = "#"
                        }
                        set nh = blockY + 2
                        if (nh > highest) { set highest = nh }
                    }
                    elseif (blockType = 3) {
                        set map(blockX,blockY) = "#"
                        set map(blockX + 1,blockY) = "#"                        
                        set map(blockX + 2,blockY) = "#"                        
                        set map(blockX + 2,blockY + 1) = "#"                        
                        set map(blockX + 2,blockY + 2) = "#"
                        set nh = blockY + 2
                        if (nh > highest) { set highest = nh }
                    }
                    elseif (blockType = 4) {
                        for dy=0:1:3 {
                            set map(blockX,blockY + dy) = "#"
                        }
                        set nh = blockY + 3
                        if (nh > highest) { set highest = nh }
                    }
                    else {
                        for dx=0:1:1 {
                            for dy=0:1:1 {
                                set map(blockX + dx,blockY + dy) = "#"
                            }
                        }
                        set nh = blockY + 1
                        if (nh > highest) { set highest = nh }
                    }
                }
                else {
                    set blockY = blockY - 1
                }
            }
                
            /*write turn,*9,blockType,*9,s,*9,blockX,*9,blockY,!
            r x */
            set turn = turn + 1
        }
            
        //do ..Display(.map,highest)

        set blockType = blockType + 1
        if (blockType > 5) { set blockType = 1 }
    }

    set result = highest
    Return result
}

Method Display(map, highest, blockX, blockY, blockType)
{
    kill nmap
    merge nmap = map
    if (blockType = 1) {
        for dx=0:1:3{
            set nmap(blockX+dx,blockY) = "@"
        }
    }
    elseif (blockType = 2) {
        set nmap(blockX,blockY) = "@"
        set nmap(blockX - 1, blockY + 1) = "@"
        set nmap(blockX + 1, blockY + 1) = "@"
        set nmap(blockX, blockY + 1) = "@"
        set nmap(blockX, blockY + 2) = "@"
    }
    elseif (blockType = 3) {
        set nmap(blockX,blockY) = "@"
        set nmap(blockX + 1,blockY) = "@"
        set nmap(blockX + 2,blockY) = "@"
        set nmap(blockX + 2,blockY + 1) = "@"
        set nmap(blockX + 2,blockY + 2) = "@"
    }
    elseif (blockType = 4) {
        for dy=0:1:3 {
            set nmap(blockX,blockY+dy) = "@"
        }
    }
    else {
        for dx=0:1:1 {
            for dy=0:1:1 {
                set nmap(blockX + dx,blockY + dy) = "@"
            }
        }
    }
    set h = highest + 8
    for y=h:-1:0 {
        for x=0:1:8 {
            if (y = 0) { write "_" }
            elseif ((x = 0) || (x = 8)) { write "|" }
            elseif ($DATA(nmap(x,y))) { write nmap(x,y) }
            else { write "." }
        }
        write !
    }
    write !
}

}
