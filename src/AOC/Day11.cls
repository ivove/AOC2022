Class AOC.Day11 Extends AOC.Base
{

Method Part1() As %Integer [ PublicList = (old, new) ]
{
    set result = 0
    set monkey = 0
    while ('..File.AtEnd) {
        set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        if (line?1"Monkey".E) {
            set monkey = $PIECE($PIECE(line," ",2),":")
        }
        elseif (line?." "1"Starting items".E) {
            set items = $TRANSLATE($PIECE(line,":",2)," ","")
            set len = $LENGTH(items,",")
            for i=1:1:len {
                set monkeys(monkey,"items") = $GET(monkeys(monkey,"items")) + 1
                set monkeys(monkey,"items",monkeys(monkey,"items")) = $PIECE(items,",",i)
            }
        }
        elseif (line?." "1"Operation".E) {
            set monkeys(monkey,"operation") = $TRANSLATE($PIECE(line,":",2)," ","")
        }
        elseif (line?." "1"Test".E) {
            set monkeys(monkey,"test") = $PIECE($PIECE(line,":",2)," ",4)
            set true = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            set monkeys(monkey,"test",1) = $PIECE($PIECE(true,":",2)," ",5)
            set false = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            set monkeys(monkey,"test",0) = $PIECE($PIECE(false,":",2)," ",5)
        }
    }

    for turn=1:1:20 {
        for m=0:1:monkey {
            set items=monkeys(m,"items")
            for i=1:1:items {
                set monkeys(m) = $GET(monkeys(m)) + 1
                set old = monkeys(m,"items",i)
                s @(monkeys(m,"operation"))
                set new = new \ 3
                if ((new # monkeys(m,"test")) = 0) {
                    set nm = monkeys(m,"test",1)
                }
                else {
                    set nm = monkeys(m,"test",0)
                }
                set monkeys(nm,"items") = $GET(monkeys(nm,"items")) + 1
                set monkeys(nm,"items",monkeys(nm,"items")) = new 
                k monkeys(m,"items",i)
                set monkeys(m,"items") = monkeys(m,"items") - 1
            }
        }
    }

    for m=0:1:monkey {
        set act(monkeys(m),m) = ""
    }
    set a = $ORDER(act(""),-1)
    set b = $ORDER(act(a),-1)
    set result = a * b

    zw monkeys
    Return result
}

Method Part2() As %Integer [ PublicList = (old, new) ]
{
    set result = 0
    set monkey = 0
    while ('..File.AtEnd) {
        set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        if (line?1"Monkey".E) {
            set monkey = $PIECE($PIECE(line," ",2),":")
        }
        elseif (line?." "1"Starting items".E) {
            set itms = $TRANSLATE($PIECE(line,":",2)," ","")
            set len = $LENGTH(itms,",")
            for i=1:1:len {
                set itm = $PIECE(itms,",",i)
                set items = $GET(items) + 1
                set items(items) = itm
                set monkeys(monkey,"items") = $GET(monkeys(monkey,"items")) + 1
                set monkeys(monkey,"items",monkeys(monkey,"items")) = items
            }
        }
        elseif (line?." "1"Operation".E) {
            set monkeys(monkey,"operation") = $PIECE(line,":",2)
        }
        elseif (line?." "1"Test".E) {
            set monkeys(monkey,"test") = $PIECE($PIECE(line,":",2)," ",4)
            set true = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            set monkeys(monkey,"test",1) = $PIECE($PIECE(true,":",2)," ",5)
            set false = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            set monkeys(monkey,"test",0) = $PIECE($PIECE(false,":",2)," ",5)
        }
    }

    for i=1:1:items {
        for m=0:1:monkey {
            set d = monkeys(m,"test")
            set rest = items(i) # d
            set items(i,d) = rest
        }
    }
    
    for turn=1:1:10000 {
        for m=0:1:monkey {
            set items=monkeys(m,"items")
            for i=1:1:items {
                set monkeys(m) = $GET(monkeys(m)) + 1
                set opp = monkeys(m,"operation")
                
                set item = monkeys(m,"items",i)
                set xopp = $PIECE(opp," ",5)
                set factor = $PIECE(opp," ",6)
                set d = $ORDER(items(item,""))
                while (d '= "") {
                    set rest = items(item,d)
                    if (xopp = "+") { set rest = (rest + factor) # d }
                    elseif (factor?.N) { set rest = (rest * factor) # d }
                    else { set rest = (rest * rest) # d }
                    set items(item,d) = rest
                    set d = $ORDER(items(item,d))
                }

                if ((items(item,monkeys(m,"test")) = 0)) {
                    set nm = monkeys(m,"test",1)
                }
                else {
                    set nm = monkeys(m,"test",0)
                }
                set monkeys(nm,"items") = $GET(monkeys(nm,"items")) + 1
                set monkeys(nm,"items",monkeys(nm,"items")) = item 
                k monkeys(m,"items",i)
                set monkeys(m,"items") = monkeys(m,"items") - 1
            }
        }
    }

    for m=0:1:monkey {
        set act(monkeys(m),m) = ""
    }
    set a = $ORDER(act(""),-1)
    set b = $ORDER(act(a),-1)
    set result = a * b

    zw act
    //zw monkeys
    Return result
}

}
