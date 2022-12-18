Class AOC.Day18 Extends AOC.Base
{

Method Part1() As %Integer
{
    set result = 0
    while ('..File.AtEnd) {
        set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set x = $PIECE(line,",")
        set y = $PIECE(line,",",2)
        set z = $PIECE(line,",",3)
        set map(x,y,z) = ""
        set cubes = $GET(cubes) + 1
        set cubes(cubes) = $LISTBUILD(x,y,z)
    }

    for i=1:1:cubes {
        set cube = cubes(i)
        set sides = 6

        set x = $LIST(cube,1)
        set y = $LIST(cube,2)
        set z = $LIST(cube,3)

        if $DATA(map(x-1,y,z)) { set sides = sides - 1 }
        if $DATA(map(x+1,y,z)) { set sides = sides - 1 }
        if $DATA(map(x,y-1,z)) { set sides = sides - 1 }
        if $DATA(map(x,y+1,z)) { set sides = sides - 1 }
        if $DATA(map(x,y,z-1)) { set sides = sides - 1 }
        if $DATA(map(x,y,z+1)) { set sides = sides - 1 }

        set result = result + sides
    }

    Return result
}

Method Part2() As %Integer
{
    set result = 0
    while ('..TestFile.AtEnd) {
        set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        set x = $PIECE(line,",")
        set y = $PIECE(line,",",2)
        set z = $PIECE(line,",",3)
        set map(x,y,z) = ""
        set cubes = $GET(cubes) + 1
        set cubes(cubes) = $LISTBUILD(x,y,z)
    }

    for i=1:1:cubes {
        set cube = cubes(i)
        set sides = 6

        set x = $LIST(cube,1)
        set y = $LIST(cube,2)
        set z = $LIST(cube,3)

        if $DATA(map(x-1,y,z)) { set sides = sides - 1 }
        if $DATA(map(x+1,y,z)) { set sides = sides - 1 }
        if $DATA(map(x,y-1,z)) { set sides = sides - 1 }
        if $DATA(map(x,y+1,z)) { set sides = sides - 1 }
        if $DATA(map(x,y,z-1)) { set sides = sides - 1 }
        if $DATA(map(x,y,z+1)) { set sides = sides - 1 }

        set result = result + sides
    }

    Return result
}

}
