Class AOC.Day4 Extends AOC.Base
{

Method Part1()
{
        set number = 0
        while ('..File.AtEnd){
            set line = ..File.ReadLine()
            set elf1 = $PIECE(line,",")
            set elf2 = $PIECE(line,",",2)
            set elf1min = $PIECE(elf1,"-")
            set elf1max = $PIECE(elf1,"-",2)
            set elf2min = $PIECE(elf2,"-")
            set elf2max = $PIECE(elf2,"-",2)
            if ((elf2min >= elf1min) && (elf2max <= elf1max)) { 
                set number = number + 1
            }            
            elseif ((elf1min >= elf2min) && (elf1max <= elf2max)) { set number = number + 1 }
        }
        return number
}

Method Part2()
{
        set number = 0
        while ('..File.AtEnd){
            set line = ..File.ReadLine()
            set elf1 = $PIECE(line,",")
            set elf2 = $PIECE(line,",",2)
            set elf1min = $PIECE(elf1,"-")
            set elf1max = $PIECE(elf1,"-",2)
            set elf2min = $PIECE(elf2,"-")
            set elf2max = $PIECE(elf2,"-",2)
            if ((elf1min >= elf2min) && (elf1min <= elf2max)) { set number = number + 1}
            elseif ((elf2min >= elf1min) && (elf2min <= elf1max)) { set number = number + 1}
            elseif ((elf2max <= elf1max) && (elf2max >= elf1min)) { set number = number + 1}
            elseif ((elf1max <= elf2max) && (elf1max >= elf2min)) { set number = number + 1}
        }
        return number
}

}
