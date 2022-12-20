Class AOC.Day19 Extends AOC.Base
{

Method Part1(Display = 0, turns = 24) As %Integer
{
    set result = 0
    set maxNumber = 0
    while ('..TestFile.AtEnd) {
        set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        //Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
        set number = $PIECE($PIECE(line,": ")," ",2)
        if (number > maxNumber) { set maxNumber = number }
        set plans = $PIECE(line,": ",2)
        set nr = $LENGTH(plans,". ")
        for r=1:1:nr {
            
            set plan = $PIECE(plans,". ",r)
            set type = $PIECE(plan," ",2)
            set BP(number,type) = ""

            set cost = $PIECE(plan,"costs ",2)
            set parts = $LENGTH(cost," and ")
            for p=1:1:parts {
                set part = $PIECE(cost," and ",p)
                set resource = $PIECE(part," ",2)
                set amount = $PIECE(part," ")
                set BP(number,type,resource) = amount
            }
        }
    }

    for i=1:1:maxNumber {
        if Display { w !,"=== BP: ",i," ===",! }
        kill robots,stock
        set robots("ore") = 1
        for m=1:1:turns {
            if Display { w !,"== Minute ",m," ==",!}
            kill prod
            //build
            for type = "geode","obsidian","clay","ore" {
                set canProduce = 1
                kill need
                set res = $ORDER(BP(i,type,""),1,amount)
                while (res '= "") {
                    set need(res) = amount
                    if ($GET(stock(res)) < amount) { set canProduce = 0 }
                    set res = $ORDER(BP(i,type,res),1,amount)
                }
                if (canProduce) {
                    set prod(type) = 1
                    set res = $ORDER(need(""),1,amount)
                    if (Display) { w "Spend " }
                    while (res '= "") {
                        if (Display) {
                            w amount," ",res,", "
                        }
                        set stock(res) = stock(res) - amount
                        set res = $ORDER(need(res),1,amount)
                    }
                    if (Display) {
                        w " to start building a ",type,"-collecting robot.",!
                    }
                }
            }
            //produce
            for resource = "ore","clay","obsidian","geode" {
                if $DATA(robots(resource)) {
                    set add = robots(resource)
                    set stock(resource) = $GET(stock(resource)) + add
                    if Display {
                        w robots(resource)," ",resource,"-collecting robot collects ",add
                        w " ",resource,"; you now have ",$GET(stock(resource))," "
                        w resource,".",!
                    }
                }
            }
            //endBuild
            set type = $ORDER(prod(""),1,amount)
            while (type '= "") {
                set robots(type) = $GET(robots(type)) + amount
                if (Display) {
                    w "The new ",type,"-collecting robot is ready; you now have ",$GET(robots(type))," of them.",!
                }
                set type = $ORDER(prod(type),1,amount)
            }
        }

    }

    Return result
}

}
