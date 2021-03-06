' 3d Maze,
' for QBASIC/FreeBasic QB GUI mode
' web: http://rudih.info
' -use Ezedit draw mode as a level editor

DIM lin$(100)

SCREEN 1

' initial statements
menu:
CLS
LOCATE 8, 10
PRINT "---3D MAZE---"
LOCATE 12, 2
PRINT "arrow keys move - <esc> quits "
PRINT " <L>oad level from 'level.txt'"
PRINT " <m>ap"
x$ = ""
WHILE x$ = ""
    x$ = INKEY$
WEND
IF x$ = "" THEN END

IF x$ = "L" OR x$ = "l" THEN
    OPEN "level.txt" FOR INPUT AS #1
    FOR a = 1 TO 100
        IF NOT EOF(1) THEN LINE INPUT #1, lin$(a)
    NEXT a
    CLOSE 1
    level = 99
    di$ = "east"
    xmap = 1
    ymap = 1
    GOTO main:
END IF
level = 1
lev:
di$ = "east"
xmap = 1
ymap = 1
IF level = 1 THEN
    lin$(1) = "ɻɻ�ͻ"
    lin$(2) = "�ȼ��͹"
    lin$(3) = "���ͼ *"
END IF
IF level = 2 THEN
    lin$(1) = "ɻ ɻɻ �ͻ"
    lin$(2) = "ȹɼ���ͼ �"
    lin$(3) = " ȼɻȼ �˼"
    lin$(4) = "*�������ʼ"
END IF
IF level = 3 THEN
    lin$(1) = "��ͻ ɻ �ͻ"
    lin$(2) = "�λ��ʹ Ȼ̻"
    lin$(3) = "ɼȻȻ��͹�λ"
    lin$(4) = "��ͼ ȼ *��ʼ"
END IF
' main loop
main:
CLS
GOSUB load:
LOCATE 22, 1
PRINT dest$; " "; di$; " x="; xmap; " y="; ymap
user$ = ""
WHILE user$ = ""
    user$ = INKEY$
WEND
IF user$ = "" GOTO menu:
IF user$ = "m" OR user$ = "M" THEN
    FOR x = 1 TO 20
        L = LEN(lin$(x))
        IF L > 38 THEN GOTO main:
    NEXT x
    CLS
    FOR x = 1 TO 20
        PRINT lin$(x)
    NEXT x
    LOCATE ymap, xmap
    PRINT "X"
    x$ = ""
    WHILE x$ = ""
        x$ = INKEY$
    WEND
    GOTO main:
END IF
' up
IF user$ = CHR$(0) + "H" THEN
    IF di$ = "east" THEN
        dest$ = MID$(lin$(ymap), xmap + 1, 1)
        IF dest$ = "�" THEN xmap = xmap + 1
        IF dest$ = "�" THEN xmap = xmap + 1
        IF dest$ = "�" THEN xmap = xmap + 1
        IF dest$ = "�" THEN xmap = xmap + 1
        IF dest$ = "�" THEN xmap = xmap + 1
        IF dest$ = "�" THEN xmap = xmap + 1
        IF dest$ = "�" THEN xmap = xmap + 1
        IF dest$ = "*" THEN xmap = xmap + 1
    END IF
    IF di$ = "west" AND xmap > 0 THEN
        dest$ = MID$(lin$(ymap), xmap - 1, 1)
        IF dest$ = "�" THEN xmap = xmap - 1
        IF dest$ = "�" THEN xmap = xmap - 1
        IF dest$ = "�" THEN xmap = xmap - 1
        IF dest$ = "�" THEN xmap = xmap - 1
        IF dest$ = "�" THEN xmap = xmap - 1
        IF dest$ = "�" THEN xmap = xmap - 1
        IF dest$ = "�" THEN xmap = xmap - 1
        IF dest$ = "*" THEN xmap = xmap - 1
    END IF
    IF di$ = "south" THEN
        dest$ = MID$(lin$(ymap + 1), xmap, 1)
        IF dest$ = "�" THEN ymap = ymap + 1
        IF dest$ = "�" THEN ymap = ymap + 1
        IF dest$ = "�" THEN ymap = ymap + 1
        IF dest$ = "�" THEN ymap = ymap + 1
        IF dest$ = "�" THEN ymap = ymap + 1
        IF dest$ = "�" THEN ymap = ymap + 1
        IF dest$ = "�" THEN ymap = ymap + 1
        IF dest$ = "*" THEN ymap = ymap + 1
    END IF
    IF di$ = "north" AND ymap > 0 THEN
        dest$ = MID$(lin$(ymap - 1), xmap, 1)
        IF dest$ = "�" THEN ymap = ymap - 1
        IF dest$ = "�" THEN ymap = ymap - 1
        IF dest$ = "�" THEN ymap = ymap - 1
        IF dest$ = "�" THEN ymap = ymap - 1
        IF dest$ = "�" THEN ymap = ymap - 1
        IF dest$ = "�" THEN ymap = ymap - 1
        IF dest$ = "�" THEN ymap = ymap - 1
        IF dest$ = "*" THEN ymap = ymap - 1
    END IF

END IF
' down
IF user$ = CHR$(0) + "P" THEN
END IF
' left
IF user$ = CHR$(0) + "K" THEN
    IF di$ = "west" THEN
        di$ = "south"
        GOTO main:
    END IF
    IF di$ = "east" THEN
        di$ = "north"
        GOTO main:
    END IF
    IF di$ = "south" THEN di$ = "east"
    IF di$ = "north" THEN di$ = "west"
END IF
' right
IF user$ = CHR$(0) + "M" THEN
    IF di$ = "west" THEN
        di$ = "north"
        GOTO main:
    END IF
    IF di$ = "north" THEN
        di$ = "east"
        GOTO main:
    END IF
    IF di$ = "south" THEN di$ = "west"
    IF di$ = "east" THEN di$ = "south"

END IF
GOTO main:

' load the screen data
load:
x$ = MID$(lin$(ymap), xmap, 1)
IF x$ = "*" THEN
    LOCATE 5, 1
    PRINT "You have found the end of"
    PRINT "the maze! Press space..."
    x$ = ""
    WHILE x$ <> " "
        x$ = INKEY$
    WEND
    IF level = 99 OR level = 3 THEN GOTO menu:
    CLS
    LOCATE 1, 1
    PRINT "...on to level: "; level + 1
    SLEEP
    level = level + 1
    GOTO lev:
END IF

IF x$ = "�" THEN
    LINE (1, 1)-(150, 150), 1
    LINE (150, 1)-(1, 150), 1
    LINE (50, 50)-(100, 100), 0
    LINE (100, 51)-(51, 100), 0
    LINE (25, 25)-(25, 125), 1
    LINE (25, 25)-(125, 25), 1
    LINE (125, 25)-(125, 125), 1
    LINE (25, 125)-(125, 125), 1
    LINE (125, 125)-(150, 125), 1
    LINE (125, 25)-(150, 25), 1
    LINE (125, 125)-(150, 125), 1
    LINE (125, 25)-(150, 25), 1
    LINE (1, 125)-(25, 125), 1
    LINE (1, 25)-(25, 25), 1

END IF
IF x$ = "�" THEN
    IF di$ = "north" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "south" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "west" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
    END IF
    IF di$ = "east" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
    END IF


END IF
IF x$ = "�" THEN
    IF di$ = "west" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "east" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "north" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
    END IF
    IF di$ = "south" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF

END IF
IF x$ = "�" THEN
    IF di$ = "west" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "east" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
    END IF
    IF di$ = "north" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "south" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF

END IF
IF x$ = "�" THEN
    IF di$ = "east" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "west" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
    END IF
    IF di$ = "south" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "north" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF

END IF
IF x$ = "�" THEN
    IF di$ = "west" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "east" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1

    END IF
    IF di$ = "north" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
    END IF
    IF di$ = "south" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF

END IF

IF x$ = "�" THEN
    IF di$ = "east" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "west" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
    END IF
    IF di$ = "north" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
    END IF
    IF di$ = "south" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF

END IF
IF x$ = "�" THEN
    IF di$ = "west" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
    END IF
    IF di$ = "east" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "north" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "south" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
    END IF

END IF

IF x$ = "�" THEN
    IF di$ = "west" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "east" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (25, 25)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
    END IF
    IF di$ = "north" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "south" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
    END IF

END IF
IF x$ = "�" THEN
    IF di$ = "east" OR di$ = "west" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "south" OR di$ = "north" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
    END IF
END IF
IF x$ = "�" THEN
    IF di$ = "east" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (26, 26)-(125, 125), 0
        LINE (125, 26)-(26, 125), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "west" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF
    IF di$ = "south" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (125, 125)-(150, 125), 1
        LINE (125, 25)-(150, 25), 1
    END IF
    IF di$ = "north" THEN
        LINE (1, 1)-(150, 150), 1
        LINE (150, 1)-(1, 150), 1
        LINE (50, 50)-(100, 100), 0
        LINE (100, 51)-(51, 100), 0
        LINE (25, 25)-(25, 125), 1
        LINE (25, 25)-(125, 25), 1
        LINE (125, 25)-(125, 125), 1
        LINE (25, 125)-(125, 125), 1
        LINE (1, 125)-(25, 125), 1
        LINE (1, 25)-(25, 25), 1
    END IF

END IF
RETURN


