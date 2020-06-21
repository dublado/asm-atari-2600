;
;************ LEVEL 1
;
level1   db   1
         db   2
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   0
         db   0
         db   0
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   0, 0
         db   item_miner_rt
         db   12, 79+topoffset
         db   0
         db   item_spider
         db   25, 67+topoffset
         db   0
         db   0
;
;************ LEVEL 2
;
level2   db   2
         db   4
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   0
         db   0
         db   0
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11110000, %00001100, %00000000, %00000000, %00001111
         db   %11111111, %10011111, %11111111, %11111001, %11111111
         db   2, 0
         db   item_spider
         db   28, 63+topoffset
         db   0
         db   0
         db   0
         db   %11111111, %10011111, %11111111, %11111001, %11111111
         db   %11110000, %00000001, %11111111, %11110000, %00001111
         db   %11111111, %11111000, %00000000, %00011111, %11111111
         db   19, 0
         db   item_bat
         db   25, 65+topoffset
         db   4
         db   item_spider
         db   39, 103+topoffset
         db   0
         db   0
         db   %11111111, %11111000, %00000000, %00011111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00111111
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   32, 0
         db   item_bat
         db   54, 65+topoffset
         db   4
         db   item_miner_lt
         db   64, 79+topoffset
         db   0
         db   0
;
;************ LEVEL 3
;
level3   db   3
         db   6
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   0
         db   0
         db   0
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00001111
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   2, 0
         db   item_lantern_on
         db   41, 29+topoffset
         db   0
         db   item_spider
         db   20, 63+topoffset
         db   0
         db   item_moth
         db   39, 107+topoffset
         db   246
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   %11100000, %00000000, %00000000, %00000000, %00001111
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   19, 0
         db   item_spider
         db   24, 67+topoffset
         db   0
         db   0
         db   0
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   %11100000, %00000000, %00011000, %00000000, %00001111
         db   %11111111, %11001111, %11111111, %11110011, %11111111
         db   36, 0
         db   item_spider
         db   20, 99+topoffset
         db   0
         db   item_lantern_on
         db   53, 27+topoffset
         db   0
         db   item_bat
         db   51, 67+topoffset
         db   6
         db   %11111111, %11001111, %11111111, %11110011, %11111111
         db   %11100000, %00000000, %00000001, %10000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   53, 0
         db   item_moth
         db   31, 67+topoffset
         db   148
         db   0
         db   0
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00001111
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   64, 0
         db   item_miner_rt
         db   6, 79+topoffset
         db   0
         db   item_moth
         db   21, 67+topoffset
         db   132
         db   0
;
;************ LEVEL 4
;
level4   db   4
         db   8
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   0
         db   0
         db   0
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   %11110011, %11111111, %11111111, %11111111, %11001111
         db   2, 0
         db   item_lantern_on
         db   41, 29+topoffset
         db   0
         db   item_spider
         db   63, 65+topoffset
         db   0
         db   0
         db   %11110011, %11111111, %11111111, %11111111, %11001111
         db   %11100000, %01111111, %11111111, %11111110, %00000111
         db   %11111110, %00111111, %11111111, %11111100, %01111111
         db   19, 0
         db   item_lantern_on
         db   9, 29+topoffset
         db   0
         db   item_bat
         db   62, 67+topoffset
         db   4
         db   0
         db   %11111110, %00111111, %11111111, %11111100, %01111111
         db   %11100000, %00011111, %11111111, %11111000, %00001111
         db   %11000001, %11111111, %11111111, %11111111, %10000111
         db   36, 0
         db   item_lantern_on
         db   17, 29+topoffset
         db   0
         db   item_spider
         db   10, 107+topoffset
         db   0
         db   item_snake
         db   58, 69+topoffset
         db   0
         db   %11000001, %11111111, %11111111, %11111111, %10000111
         db   %11100000, %00000000, %00000001, %10000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   53, 0
         db   item_lantern_on
         db   11, 29+topoffset
         db   0
         db   item_moth
         db   32, 67+topoffset
         db   148
         db   0
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11000000, %00110000, %00000000, %00000000, %00001111
         db   %11100111, %11111111, %11111111, %11111111, %10011111
         db   70, 0
         db   item_lantern_on
         db   41, 29+topoffset
         db   0
         db   item_spider
         db   52, 67+topoffset
         db   0
         db   0
         db   %11100111, %11111111, %11111111, %11111111, %10011111
         db   %11000000, %00110000, %00000000, %00000000, %00001111
         db   %11111111, %11111100, %00000000, %00111111, %11111111
         db   87, 0
         db   item_lantern_on
         db   67, 29+topoffset
         db   0
         db   item_spider
         db   65, 69+topoffset
         db   0
         db   item_bat
         db   39, 103+topoffset
         db   7
         db   %11111111, %11111100, %00000000, %00111111, %11111111
         db   %11000000, %00000000, %00111100, %00000000, %00001111
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   96, 0
         db   item_snake
         db   44, 69+topoffset
         db   0
         db   item_miner_lt
         db   68, 79+topoffset
         db   0
         db   0
;
;************ LEVEL 5
;
level5   db   5
         db   8
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   0
         db   0
         db   0
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   0, 32
         db   (item_lantern_on or wall_mask_flash)
         db   41, 29+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   14, 67+topoffset
         db   198
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00000000
         db   %11111000, %00000000, %00000000, %00000000, %01111111
         db   3, 1
         db   item_spider
         db   38, 61+topoffset
         db   0
         db   item_moth
         db   44, 99+topoffset
         db   198
         db   0
         db   %11111000, %00000000, %00000000, %00000000, %01111111
         db   %11111111, %11100000, %00000000, %00001111, %11111111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   36, 0
         db   (item_lantern_on or wall_mask_flash)
         db   63, 29+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   38, 65+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11000000, %00001100, %00000000, %00000000, %00011111
         db   %11110011, %11111111, %11111111, %11111110, %01111111
         db   53, 0
         db   item_lantern_on
         db   39, 27+topoffset
         db   0
         db   item_moth
         db   12, 67+topoffset
         db   105
         db   0
         db   %11110011, %11111111, %11111111, %11111110, %01111111
         db   %11000000, %00011000, %00000000, %00000000, %00011111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   70, 0
         db   (item_lantern_on or wall_mask_flash)
         db   63, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   38, 65+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11000000, %00000011, %00000000, %00000000, %00011111
         db   %11111111, %11001111, %11111111, %11110011, %11111111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   20, 65+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   56, 99+topoffset
         db   4
         db   %11111111, %11001111, %11111111, %11110011, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00011111
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   96, 0
         db   item_miner_lt
         db   62, 79+topoffset
         db   0
         db   item_moth
         db   46, 67+topoffset
         db   103
         db   0
;
;************ LEVEL 6
;
level6   db   6
         db   10
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11100000, %00000001, %10000000, %00000000, %00001111
         db   %11110000, %00000011, %11111111, %11000000, %00011111
         db   2, 0
         db   item_lantern_on
         db   41, 27+topoffset
         db   0
         db   item_moth
         db   16, 95+topoffset
         db   134
         db   item_bat
         db   47, 67+topoffset
         db   5
         db   %11110000, %00000011, %11111111, %11000000, %00011111
         db   %11100000, %00000000, %00000001, %10000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   19, 0
         db   (item_lantern_on or wall_mask_flash)
         db   67, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   35, 65+topoffset
         db   5
         db   (item_spider or wall_mask_flash)
         db   40, 101+topoffset
         db   0
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11110000, %00000000, %00000000, %00000000, %00001111
         db   %11111001, %11111001, %11111111, %10011111, %10011111
         db   36, 0
         db   item_lantern_on
         db   41, 27+topoffset
         db   0
         db   item_moth
         db   19, 67+topoffset
         db   181
         db   item_spider
         db   50, 101+topoffset
         db   0
         db   %11111001, %11111001, %11111111, %10011111, %10011111
         db   %11111111, %11100000, %00011000, %00000111, %11111111
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   51, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   48, 65+topoffset
         db   86
         db   (0 or wall_mask_flash)
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   %11000000, %00001111, %11111111, %10000000, %00011111
         db   %11111111, %10000000, %00000000, %00000000, %11111111
         db   70, 0
         db   item_lantern_on
         db   25, 27+topoffset
         db   0
         db   item_bat
         db   59, 67+topoffset
         db   6
         db   item_spider
         db   28, 105+topoffset
         db   0
         db   %11111111, %10000000, %00000000, %00000000, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00000011
         db   %11111001, %11111111, %11111111, %11111111, %11001111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   61, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   10, 101+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   67, 67+topoffset
         db   5
         db   %11111001, %11111111, %11111111, %11111111, %11001111
         db   %11000000, %00000000, %00011000, %00000000, %00000011
         db   %11111111, %11100111, %11111111, %11100111, %11111111
         db   104, 0
         db   item_lantern_on
         db   11, 27+topoffset
         db   0
         db   item_bat
         db   32, 67+topoffset
         db   5
         db   item_spider
         db   54, 99+topoffset
         db   0
         db   %11111111, %11100111, %11111111, %11100111, %11111111
         db   %11110000, %00000011, %00000000, %00000000, %00001111
         db   %11111111, %11111111, %10000111, %11111111, %11111111
         db   121, 0
         db   (item_lantern_on or wall_mask_flash)
         db   55, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   11, 67+topoffset
         db   118
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %10000111, %11111111, %11111111
         db   %11110000, %00000000, %00000000, %00000000, %00001111
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   128, 0
         db   item_miner_rt
         db   8, 79+topoffset
         db   0
         db   item_spider
         db   25, 65+topoffset
         db   0
         db   0
;
;************ LEVEL 7
;
level7   db   7
         db   12
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11110000, %00000000, %00000001, %10000000, %00001111
         db   %11111001, %11111111, %11111111, %11111111, %10011111
         db   2, 0
         db   item_lantern_on
         db   41, 27+topoffset
         db   0
         db   item_spider
         db   26, 67+topoffset
         db   0
         db   0
         db   %11111001, %11111111, %11111111, %11111111, %10011111
         db   %11100000, %00000001, %10000000, %00000000, %00000111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   19, 0
         db   (item_lantern_on or wall_mask_flash)
         db   11, 25+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   44, 67+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11111111, %11110000, %11000000, %00001111, %11111111
         db   %11111111, %11111001, %11111111, %10011111, %11111111
         db   36, 0
         db   item_lantern_on
         db   39, 27+topoffset
         db   0
         db   item_snake
         db   24, 65+topoffset
         db   0
         db   0
         db   %11111111, %11111001, %11111111, %10011111, %11111111
         db   %11111110, %00000000, %11111111, %11110000, %00001111
         db   %11111000, %01111111, %11111111, %11111100, %00111111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   51, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   17, 65+topoffset
         db   69
         db   (item_snake or wall_mask_flash)
         db   10, 105+topoffset
         db   0
         db   %11111000, %01111111, %11111111, %11111100, %00111111
         db   %11111110, %00000000, %00000000, %01100000, %11111111
         db   %11100000, %00011111, %11111111, %11110000, %00000111
         db   70, 0
         db   item_lantern_on
         db   65, 27+topoffset
         db   0
         db   item_spider
         db   29, 63+topoffset
         db   0
         db   item_moth
         db   63, 105+topoffset
         db   71
         db   %11100000, %00011111, %11111111, %11110000, %00000111
         db   %11111111, %10000111, %11111111, %11111100, %00011111
         db   %11100000, %11111111, %11111111, %11111110, %00000111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   19, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   66, 65+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   10, 105+topoffset
         db   4
         db   %11100000, %11111111, %11111111, %11111110, %00000111
         db   %11111100, %00000000, %00000000, %01100000, %01111111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   104, 0
         db   item_lantern_on
         db   13, 29+topoffset
         db   0
         db   item_snake
         db   12, 67+topoffset
         db   0
         db   item_spider
         db   40, 103+topoffset
         db   0
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11111100, %00000001, %10000000, %00000000, %01111111
         db   %11111110, %00011111, %11111111, %11110000, %11111111
         db   121, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   51, 65+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111110, %00011111, %11111111, %11110000, %11111111
         db   %11111000, %00000000, %00000000, %01100000, %00111111
         db   %11111111, %11111111, %00111100, %11111111, %11111111
         db   138, 0
         db   item_lantern_on
         db   61, 27+topoffset
         db   0
         db   item_spider
         db   38, 65+topoffset
         db   0
         db   0
         db   %11111111, %11111111, %00111100, %11111111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00000000
         db   %11111110, %00000000, %00000000, %00000000, %11111111
         db   144, 11
         db   ((item_lantern_on or wall_mask_flash) or item_bottm_water)
         db   33, 27+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   36, 101+topoffset
         db   0
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   64, 65+topoffset
         db   4
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   0, 160
         db   item_bat
         db   35, 65+topoffset
         db   4
         db   item_miner_lt
         db   64, 79+topoffset
         db   0
         db   0
;
;************ LEVEL 8
;
level8   db   8
         db   14
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   2, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   30, 63+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   40, 103+topoffset
         db   0
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   %11111111, %11111111, %10000001, %11111111, %11111111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   19, 0
         db   (item_lantern_on or wall_mask_flash)
         db   57, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   40, 105+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11000000, %00000001, %10000000, %00000000, %00000011
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   36, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   14, 65+topoffset
         db   166
         db   (item_spider or wall_mask_flash)
         db   52, 99+topoffset
         db   0
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   %11111111, %00000001, %11111111, %10000000, %11111111
         db   %11111110, %00000111, %11111111, %11100000, %01111111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   53, 27+topoffset
         db   0
         db   (item_snake or wall_mask_flash)
         db   14, 105+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111110, %00000111, %11111111, %11100000, %01111111
         db   %11111111, %00000001, %10000000, %00000000, %11111111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   70, 0
         db   (item_lantern_on or wall_mask_flash)
         db   63, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   38, 63+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11000000, %00000001, %10000000, %00000000, %00001111
         db   %11110011, %11111111, %11111111, %11111111, %00111111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   56, 63+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11110011, %11111111, %11111111, %11111111, %00111111
         db   %11000000, %00000000, %11111111, %00000110, %00001111
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   104, 0
         db   (item_lantern_on or wall_mask_flash)
         db   9, 27+topoffset
         db   0
         db   (item_snake or wall_mask_flash)
         db   48, 67+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   %11111100, %00000000, %00111100, %00000000, %00111111
         db   %11000000, %00000011, %11111111, %11000000, %00000011
         db   121, 0
         db   (item_lantern_on or wall_mask_flash)
         db   53, 25+topoffset
         db   0
         db   (item_snake or wall_mask_flash)
         db   52, 105+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11000000, %00000011, %11111111, %11000000, %00000011
         db   %11111110, %00001111, %11111111, %11110000, %00111111
         db   %11110000, %00000000, %11111111, %00000000, %00001111
         db   138, 0
         db   (item_lantern_on or wall_mask_flash)
         db   25, 25+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11110000, %00000000, %11111111, %00000000, %00001111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111111, %10000000, %00000000, %00000001, %11111111
         db   144, 176
         db   ((item_lantern_on or wall_mask_flash) or item_bottm_water)
         db   29, 27+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   38, 65+topoffset
         db   0
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00110000, %00000011, %11111111, %11000000, %00000000
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   0, 202
         db   (item_snake or item_bottm_water)
         db   52, 65+topoffset
         db   0
         db   (item_moth or item_bottm_water)
         db   38, 97+topoffset
         db   164
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00110000, %00000000, %00011000, %00000000, %00000000
         db   %11111110, %00000000, %00111100, %00000000, %01111111
         db   0, 219
         db   (item_spider or item_bottm_water)
         db   17, 61+topoffset
         db   0
         db   (item_snake or item_bottm_water)
         db   44, 101+topoffset
         db   0
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   0, 12
         db   item_miner_rt
         db   9, 79+topoffset
         db   0
         db   item_spider
         db   35, 65+topoffset
         db   0
         db   0
;
;************ LEVEL 9
;
level9   db   9
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11110000, %00000110, %00000000, %00000000, %00001111
         db   %11111100, %00111111, %11111111, %11111100, %00111111
         db   2, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   14, 65+topoffset
         db   4
         db   (item_spider or wall_mask_flash)
         db   62, 101+topoffset
         db   0
         db   %11111100, %00111111, %11111111, %11111100, %00111111
         db   %11111000, %00011111, %11111111, %11111000, %00011111
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   19, 0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   25, 101+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   %11111111, %00001111, %11111111, %11110000, %11111111
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   36, 0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   31, 103+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   %11111111, %11100001, %11111111, %10000111, %11111111
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   %11111111, %11111100, %00111100, %00111111, %11111111
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   70, 0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   39, 103+topoffset
         db   148
         db   (0 or wall_mask_flash)
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   %11111111, %11111000, %00000000, %00011111, %11111111
         db   %11111111, %11111100, %00111100, %00111111, %11111111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   46, 61+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111111, %11111100, %00111100, %00111111, %11111111
         db   %11000000, %00000000, %00000000, %00001100, %00001111
         db   %11110011, %11111111, %11111111, %11111111, %00111111
         db   104, 0
         db   (item_lantern_on or wall_mask_flash)
         db   33, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   8, 99+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11110011, %11111111, %11111111, %11111111, %00111111
         db   %11000000, %01100000, %00000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   121, 0
         db   (item_lantern_on or wall_mask_flash)
         db   9, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   30, 61+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11111111, %11111111, %10000001, %11111111, %11111111
         db   %11110000, %00000000, %00000000, %00000000, %00111111
         db   138, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   42, 63+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   21, 99+topoffset
         db   163
         db   %11110000, %00000000, %00000000, %00000000, %00111111
         db   %11000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11100000, %00000000, %00000111, %11111111
         db   144, 11
         db   ((item_lantern_on or wall_mask_flash) or item_bottm_water)
         db   65, 27+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   63, 65+topoffset
         db   0
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   39, 101+topoffset
         db   116
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00001100
         db   %11111111, %10000000, %00000000, %00000001, %11111111
         db   0, 172
         db   (item_moth or item_bottm_water)
         db   27, 103+topoffset
         db   244
         db   (0 or item_bottm_water)
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11110000, %00000000, %00111100, %00000000, %00111111
         db   0, 189
         db   (item_spider or item_bottm_water)
         db   55, 61+topoffset
         db   0
         db   (0 or item_bottm_water)
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %11111111, %00000000, %00001100
         db   %11111111, %11100000, %00000000, %00000111, %11111111
         db   0, 206
         db   (item_moth or item_bottm_water)
         db   35, 95+topoffset
         db   116
         db   (item_spider or item_bottm_water)
         db   58, 61+topoffset
         db   0
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00011111, %11111111, %11111000, %00000000
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   0, 223
         db   (item_spider or item_bottm_water)
         db   68, 61+topoffset
         db   0
         db   (0 or item_bottm_water)
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   0, 224
         db   item_spider
         db   36, 63+topoffset
         db   0
         db   item_miner_lt
         db   64, 79+topoffset
         db   0
         db   0
;
;************ LEVEL 10
;
level10  db   10
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00011000, %00001111
         db   %11111100, %11111111, %11111111, %11111111, %00111111
         db   2, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   22, 63+topoffset
         db   195
         db   (item_bat or wall_mask_flash)
         db   12, 99+topoffset
         db   4
         db   %11111100, %11111111, %11111111, %11111111, %00111111
         db   %11000000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   19, 0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   50, 61+topoffset
         db   163
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00011000, %00001111
         db   %11111110, %01111111, %11100111, %11111110, %00111111
         db   36, 0
         db   (item_lantern_on or wall_mask_flash)
         db   39, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   20, 61+topoffset
         db   163
         db   (item_bat or wall_mask_flash)
         db   14, 97+topoffset
         db   4
         db   %11111110, %01111111, %11100111, %11111110, %00111111
         db   %11111111, %11000011, %11111111, %11111100, %00011111
         db   %11111110, %01111111, %11111111, %11111110, %01111111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   39, 27+topoffset
         db   0
         db   (item_snake or wall_mask_flash)
         db   60, 65+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111110, %01111111, %11111111, %11111110, %01111111
         db   %11000000, %00011111, %11111111, %11111000, %00001111
         db   %11111111, %10001111, %11111111, %11110001, %11111111
         db   70, 0
         db   (item_lantern_on or wall_mask_flash)
         db   15, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   20, 101+topoffset
         db   0
         db   (item_snake or wall_mask_flash)
         db   58, 65+topoffset
         db   0
         db   %11111111, %10001111, %11111111, %11110001, %11111111
         db   %11000000, %00000000, %00000011, %00000000, %00001111
         db   %11100001, %11111111, %10000111, %11111110, %00011111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   21, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   27, 63+topoffset
         db   163
         db   (item_bat or wall_mask_flash)
         db   64, 99+topoffset
         db   6
         db   %11100001, %11111111, %10000111, %11111110, %00011111
         db   %11110011, %11111111, %11001111, %11111111, %00111111
         db   %11000000, %00000000, %00000000, %00000000, %00001111
         db   104, 0
         db   (item_lantern_on or wall_mask_flash)
         db   67, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   8, 61+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   23, 97+topoffset
         db   163
         db   %11000000, %00000000, %00000000, %00000000, %00001111
         db   %11111111, %11111111, %10000111, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00001111
         db   121, 0
         db   (item_lantern_on or wall_mask_flash)
         db   69, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   25, 99+topoffset
         db   131
         db   (0 or wall_mask_flash)
         db   %11000000, %00000000, %00000000, %00000000, %00001111
         db   %11111111, %11111110, %00000001, %11111111, %11111111
         db   %11110000, %00000000, %00000000, %00000000, %00111111
         db   138, 0
         db   (item_lantern_on or wall_mask_flash)
         db   69, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   42, 59+topoffset
         db   8
         db   (item_moth or wall_mask_flash)
         db   19, 99+topoffset
         db   163
         db   %11110000, %00000000, %00000000, %00000000, %00111111
         db   %00000000, %00111111, %11111111, %11110000, %00000011
         db   %11111100, %00000000, %00000000, %00000000, %11111111
         db   144, 176
         db   ((item_lantern_on or wall_mask_flash) or item_bottm_water)
         db   65, 27+topoffset
         db   0
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   4, 61+topoffset
         db   3
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   14, 99+topoffset
         db   246
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000000
         db   %11111000, %00000000, %00000000, %00000000, %01111111
         db   0, 202
         db   (item_moth or item_bottm_water)
         db   21, 59+topoffset
         db   163
         db   (item_moth or item_bottm_water)
         db   29, 95+topoffset
         db   180
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11110000, %00000000, %00111100, %00000000, %00111111
         db   0, 219
         db   (item_bat or item_bottm_water)
         db   30, 61+topoffset
         db   4
         db   (item_snake or item_bottm_water)
         db   44, 101+topoffset
         db   0
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00111100, %00000000, %00000000
         db   %11110000, %00000000, %00000000, %00000000, %00111111
         db   0, 236
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   61, 125+topoffset
         db   16
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11111111, %00000000, %00111100, %00000001, %11111111
         db   0, 253
         db   (item_moth or item_bottm_water)
         db   28, 61+topoffset
         db   67
         db   (item_moth or item_bottm_water)
         db   24, 97+topoffset
         db   84
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   0, 14
         db   item_miner_rt
         db   9, 79+topoffset
         db   0
         db   item_moth
         db   31, 63+topoffset
         db   243
         db   0
;
;************ LEVEL 11
;
level11  db   11
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11111111, %11100000, %00000000, %00000111, %11111111
         db   2, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   26, 101+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111111, %11100000, %00000000, %00000111, %11111111
         db   %11100001, %10000000, %00111100, %00000000, %00011111
         db   %11110011, %11111111, %11111111, %11111111, %00111111
         db   19, 0
         db   (item_lantern_on or wall_mask_flash)
         db   55, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   18, 63+topoffset
         db   115
         db   (item_bat or wall_mask_flash)
         db   64, 95+topoffset
         db   4
         db   %11110011, %11111111, %11111111, %11111111, %00111111
         db   %11100000, %00000110, %00000000, %00000000, %00011111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   36, 0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   12, 65+topoffset
         db   131
         db   (item_spider or wall_mask_flash)
         db   40, 101+topoffset
         db   0
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11100000, %00000111, %10000001, %11100000, %00000111
         db   %11110011, %11001111, %11100111, %11110011, %11001111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   8, 97+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   60, 63+topoffset
         db   115
         db   %11110011, %11001111, %11100111, %11110011, %11001111
         db   %11110011, %10000000, %00000000, %00000001, %11001111
         db   %11110011, %11111111, %11111111, %11111111, %11001111
         db   70, 0
         db   (item_lantern_on or wall_mask_flash)
         db   21, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   8, 97+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11110011, %11111111, %11111111, %11111111, %11001111
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   69, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   38, 63+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   31, 93+topoffset
         db   243
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00001111
         db   104, 0
         db   (item_lantern_on or wall_mask_flash)
         db   57, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   31, 97+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11100000, %00000000, %00000000, %00000000, %00001111
         db   %11111111, %11111100, %00111100, %00111111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00001111
         db   121, 0
         db   (item_lantern_on or wall_mask_flash)
         db   69, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   46, 65+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   38, 97+topoffset
         db   4
         db   %11100000, %00000000, %00000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11111111, %11110000, %00000000, %00001111, %11111111
         db   138, 0
         db   (item_lantern_on or wall_mask_flash)
         db   69, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   50, 99+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111111, %11110000, %00000000, %00001111, %11111111
         db   %11100000, %00111100, %00111100, %00111100, %00000000
         db   %11111000, %00000000, %01111110, %00000000, %00011111
         db   144, 11
         db   (item_lantern_on or item_bottm_water)
         db   53, 27+topoffset
         db   0
         db   (item_spider or item_bottm_water)
         db   30, 63+topoffset
         db   0
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11111100, %00000000, %00111100, %00000000, %00111111
         db   0, 172
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   44, 63+topoffset
         db   244
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   58, 93+topoffset
         db   4
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00111100, %00000000, %00000000
         db   %11110000, %00000000, %00000000, %00000000, %00001111
         db   0, 189
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   9, 125+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   29, 99+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   66, 61+topoffset
         db   0
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11111111, %11110000, %11111111, %00001111, %11111111
         db   0, 206
         db   (item_moth or item_bottm_water)
         db   46, 59+topoffset
         db   131
         db   (item_spider or item_bottm_water)
         db   50, 99+topoffset
         db   0
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11110000, %00011111, %11111111, %11111000, %00001111
         db   0, 223
         db   (item_spider or item_bottm_water)
         db   13, 101+topoffset
         db   0
         db   (item_bat or item_bottm_water)
         db   62, 61+topoffset
         db   4
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   0, 224
         db   item_moth
         db   19, 63+topoffset
         db   243
         db   item_miner_lt
         db   64, 79+topoffset
         db   0
         db   0
;
;************ LEVEL 12
;
level12  db   12
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11110000, %00001100, %00000000, %00000000, %00001111
         db   %11111001, %11111111, %11111111, %11111111, %00111111
         db   2, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   14, 63+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   64, 95+topoffset
         db   4
         db   %11111001, %11111111, %11111111, %11111111, %00111111
         db   %11000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   16, 3
         db   (item_lantern_on or wall_mask_flash)
         db   11, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   38, 63+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111111, %10011111, %11111111, %11111001, %11111111
         db   4, 32
         db   (item_bat or wall_mask_flash)
         db   18, 97+topoffset
         db   4
         db   (item_spider or wall_mask_flash)
         db   58, 61+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111111, %10011111, %11111111, %11111001, %11111111
         db   %11000000, %00000110, %00000000, %00000000, %00011111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   59, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   31, 63+topoffset
         db   163
         db   (item_snake or wall_mask_flash)
         db   36, 105+topoffset
         db   0
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11111111, %10000000, %00000000, %01100001, %11111111
         db   %11100000, %00011111, %11111111, %11111000, %00000111
         db   70, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   46, 61+topoffset
         db   4
         db   (item_spider or wall_mask_flash)
         db   18, 99+topoffset
         db   0
         db   %11100000, %00011111, %11111111, %11111000, %00000111
         db   %11111110, %01111111, %11111111, %11111110, %01111111
         db   %11111000, %00000000, %00000000, %00000000, %00011111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   71, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   46, 97+topoffset
         db   244
         db   (0 or wall_mask_flash)
         db   %11111000, %00000000, %00000000, %00000000, %00011111
         db   %11100000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   96, 8
         db   (item_lantern_on or wall_mask_flash)
         db   67, 29+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   60, 63+topoffset
         db   212
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000111, %11111111, %11100000, %00000011
         db   %11111111, %10000000, %00000000, %00000001, %11111111
         db   9, 112
         db   (item_spider or wall_mask_flash)
         db   14, 61+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   21, 101+topoffset
         db   244
         db   (0 or wall_mask_flash)
         db   %11111111, %10000000, %00000000, %00000001, %11111111
         db   %11100000, %00011111, %11111111, %11111000, %00001111
         db   %11111111, %10000000, %00000000, %00000001, %11111111
         db   138, 0
         db   (item_lantern_on or wall_mask_flash)
         db   59, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   7, 59+topoffset
         db   116
         db   (item_moth or wall_mask_flash)
         db   41, 101+topoffset
         db   244
         db   %11111111, %10000000, %00000000, %00000001, %11111111
         db   %00000000, %00000000, %00111100, %00000000, %00000111
         db   %11111100, %00000000, %01111110, %00000000, %00111111
         db   144, 176
         db   ((item_lantern_on or wall_mask_flash) or item_bottm_water)
         db   59, 27+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   7, 61+topoffset
         db   0
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   46, 95+topoffset
         db   4
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11100000, %00000000, %01111110, %00000000, %00000111
         db   0, 202
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   2, 61+topoffset
         db   180
         db   ((item_snake or wall_mask_flash) or item_bottm_water)
         db   46, 101+topoffset
         db   0
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000001, %10000000, %00111100, %00000000, %00000000
         db   %11111111, %11110000, %00000000, %00001111, %11111111
         db   0, 219
         db   (item_snake or item_bottm_water)
         db   44, 63+topoffset
         db   0
         db   (0 or item_bottm_water)
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11100000, %00000000, %00111100, %00000000, %00000111
         db   0, 236
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   20, 59+topoffset
         db   179
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   51, 101+topoffset
         db   0
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00111100, %00000000, %00000000
         db   %11110000, %00000000, %00000000, %00000000, %00001111
         db   0, 253
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   64, 125+topoffset
         db   16
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   30, 101+topoffset
         db   0
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   8, 63+topoffset
         db   244
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   0, 14
         db   ((item_miner_rt or wall_mask_flash) or item_bottm_water)
         db   8, 79+topoffset
         db   0
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   33, 65+topoffset
         db   180
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   23, 99+topoffset
         db   211
;
;************ LEVEL 13
;
level13  db   13
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11110000, %11000011, %10000001, %11000000, %00001111
         db   %11111001, %11100111, %11000011, %11100111, %10011111
         db   2, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   10, 63+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   54, 99+topoffset
         db   0
         db   %11111001, %11100111, %11000011, %11100111, %10011111
         db   %11111001, %11000000, %00000000, %00000011, %10011111
         db   %11110000, %11111111, %11111111, %11111111, %00001111
         db   19, 0
         db   (item_lantern_on or wall_mask_flash)
         db   23, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   25, 61+topoffset
         db   244
         db   (0 or wall_mask_flash)
         db   %11110000, %11111111, %11111111, %11111111, %00001111
         db   %11111000, %00000000, %00011000, %00000000, %00011111
         db   %11111111, %11001111, %11111111, %11110011, %11111111
         db   36, 0
         db   (item_lantern_on or wall_mask_flash)
         db   13, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   18, 63+topoffset
         db   115
         db   (0 or wall_mask_flash)
         db   %11111111, %11001111, %11111111, %11110011, %11111111
         db   %11111111, %00000000, %00011000, %00000000, %11111111
         db   %11110000, %00111111, %11111111, %11111100, %00001111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   21, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   46, 63+topoffset
         db   115
         db   (0 or wall_mask_flash)
         db   %11110000, %00111111, %11111111, %11111100, %00001111
         db   %11111100, %00111111, %11111111, %11111100, %00111111
         db   %11110000, %11111111, %11111111, %11111111, %00001111
         db   70, 0
         db   (item_lantern_on or wall_mask_flash)
         db   69, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   64, 59+topoffset
         db   4
         db   (item_spider or wall_mask_flash)
         db   68, 97+topoffset
         db   0
         db   %11110000, %11111111, %11111111, %11111111, %00001111
         db   %11110000, %00111111, %11111111, %11111100, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   80, 7
         db   (item_lantern_on or wall_mask_flash)
         db   69, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   68, 63+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   8, 96
         db   (item_moth or wall_mask_flash)
         db   25, 61+topoffset
         db   228
         db   (item_bat or wall_mask_flash)
         db   40, 95+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00000011
         db   %11111111, %11001111, %11111111, %11110011, %11111111
         db   121, 0
         db   item_lantern_on
         db   41, 27+topoffset
         db   0
         db   item_spider
         db   26, 63+topoffset
         db   0
         db   item_bat
         db   56, 95+topoffset
         db   4
         db   %11111111, %11001111, %11111111, %11110011, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   128, 160
         db   (item_lantern_on or wall_mask_flash)
         db   21, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   2, 61+topoffset
         db   228
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   0, 185
         db   (item_moth or wall_mask_flash)
         db   47, 63+topoffset
         db   244
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11100000, %00000000, %01111110, %00000000, %00000111
         db   0, 202
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   30, 63+topoffset
         db   0
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   54, 99+topoffset
         db   115
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %01111110, %00000000, %00000000
         db   %11111000, %00000000, %00000000, %00000000, %00011111
         db   0, 219
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   62, 125+topoffset
         db   16
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   38, 99+topoffset
         db   0
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   13, 61+topoffset
         db   115
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11110000, %00000000, %00111100, %00000000, %00001111
         db   0, 236
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   22, 63+topoffset
         db   148
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   48, 99+topoffset
         db   244
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11100001, %11111111, %10000111, %11111111
         db   0, 253
         db   (item_moth or item_bottm_water)
         db   30, 61+topoffset
         db   244
         db   (item_bat or item_bottm_water)
         db   52, 95+topoffset
         db   4
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   0, 14
         db   (item_miner_rt or item_bottm_water)
         db   8, 79+topoffset
         db   0
         db   (item_moth or item_bottm_water)
         db   25, 59+topoffset
         db   244
         db   (item_moth or item_bottm_water)
         db   25, 97+topoffset
         db   244
;
;************ LEVEL 14
;
level14  db   14
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   0, 32
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   20, 65+topoffset
         db   244
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   3, 1
         db   (item_moth or wall_mask_flash)
         db   49, 63+topoffset
         db   212
         db   (item_snake or wall_mask_flash)
         db   36, 103+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   32, 4
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   36, 67+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111100, %00111111, %11000011, %11111100, %00111111
         db   5, 48
         db   (item_bat or wall_mask_flash)
         db   53, 63+topoffset
         db   4
         db   (item_snake or wall_mask_flash)
         db   36, 103+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111100, %00111111, %11000011, %11111100, %00111111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11111111, %11110000, %00000000, %00001111, %11111111
         db   70, 0
         db   ((item_moth or wall_mask_flash) or wall_mask_crush)
         db   26, 99+topoffset
         db   115
         db   ((0 or wall_mask_flash) or wall_mask_crush)
         db   ((0 or wall_mask_flash) or wall_mask_crush)
         db   %11111111, %11110000, %00000000, %00001111, %11111111
         db   %11000000, %00001111, %11111110, %00000000, %00111111
         db   %11100000, %00011111, %11111111, %11111000, %00000111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   53, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   64, 61+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11100000, %00011111, %11111111, %11111000, %00000111
         db   %11000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   96, 8
         db   (item_lantern_on or wall_mask_flash)
         db   71, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   72, 63+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111000, %00000111, %11111111, %11100000, %00011111
         db   9, 112
         db   (item_bat or wall_mask_flash)
         db   17, 97+topoffset
         db   4
         db   (item_moth or wall_mask_flash)
         db   31, 63+topoffset
         db   212
         db   (0 or wall_mask_flash)
         db   %11111000, %00000111, %11111111, %11100000, %00011111
         db   %11111111, %11000000, %00000011, %00000011, %11111111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   138, 0
         db   (item_spider or wall_mask_flash)
         db   21, 61+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11100000, %00111110, %00000000, %01111100, %00000000
         db   %11110000, %00000000, %00000000, %00000000, %00011111
         db   144, 11
         db   (item_lantern_on or item_bottm_water)
         db   39, 27+topoffset
         db   0
         db   (item_moth or item_bottm_water)
         db   9, 95+topoffset
         db   131
         db   (item_bat or item_bottm_water)
         db   34, 63+topoffset
         db   4
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11110000, %00000000, %01111110, %00000000, %00001111
         db   0, 172
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   19, 59+topoffset
         db   148
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   47, 97+topoffset
         db   163
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %01111110, %00000000, %00001100
         db   %11110000, %00000000, %00000000, %00000000, %00111111
         db   0, 189
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   10, 125+topoffset
         db   0
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   27, 65+topoffset
         db   4
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   35, 97+topoffset
         db   0
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11110000, %00000000, %00111100, %00000000, %00111111
         db   0, 206
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   13, 61+topoffset
         db   0
         db   ((item_snake or wall_mask_flash) or item_bottm_water)
         db   44, 101+topoffset
         db   0
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00001100, %00000000, %00000000, %00000000
         db   %11110000, %00011110, %00000000, %01111000, %00001111
         db   0, 223
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   32, 97+topoffset
         db   179
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   56, 61+topoffset
         db   0
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111111, %11000000, %00111100, %00000011, %11111111
         db   0, 224
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   44, 61+topoffset
         db   4
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   46, 99+topoffset
         db   0
         db   ((item_miner_lt or wall_mask_flash) or item_bottm_water)
         db   66, 79+topoffset
         db   0
;
;************ LEVEL 15
;
level15  db   15
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11111111, %10000000, %00000001, %10000001, %11111111
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   2, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   21, 57+topoffset
         db   243
         db   (0 or wall_mask_flash)
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   %11111111, %11000000, %11111111, %11111100, %00001111
         db   %11111111, %11111100, %00000000, %00111111, %11111111
         db   19, 0
         db   (item_lantern_on or wall_mask_flash)
         db   53, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   28, 61+topoffset
         db   4
         db   (item_spider or wall_mask_flash)
         db   32, 101+topoffset
         db   0
         db   %11111111, %11111100, %00000000, %00111111, %11111111
         db   %11100000, %00000000, %00000000, %00011000, %00000111
         db   %11111111, %00111111, %11111111, %11111100, %11111111
         db   36, 0
         db   (item_lantern_on or wall_mask_flash)
         db   49, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   23, 63+topoffset
         db   244
         db   (0 or wall_mask_flash)
         db   %11111111, %00111111, %11111111, %11111100, %11111111
         db   %11100000, %00001100, %00000000, %00000000, %00000111
         db   %11111111, %11111110, %00000000, %01111111, %11111111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   17, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   34, 99+topoffset
         db   179
         db   (item_bat or wall_mask_flash)
         db   16, 59+topoffset
         db   4
         db   %11111111, %11111110, %00000000, %01111111, %11111111
         db   %11100000, %00011000, %00000000, %00000000, %00000111
         db   %11111100, %11111111, %11100111, %11111111, %00111111
         db   70, 0
         db   (item_lantern_on or wall_mask_flash)
         db   47, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   38, 59+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111100, %11111111, %11100111, %11111111, %00111111
         db   %11100000, %00000000, %11111111, %00000000, %00000111
         db   %11111100, %00001111, %11111111, %11110000, %00111111
         db   87, 0
         db   (item_spider or wall_mask_flash)
         db   11, 61+topoffset
         db   0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_snake or wall_mask_flash)
         db   56, 103+topoffset
         db   0
         db   %11111100, %00001111, %11111111, %11110000, %00111111
         db   %11100000, %00000000, %00011000, %00000000, %00000111
         db   %11111100, %11111111, %11111111, %11111111, %00111111
         db   104, 0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   12, 63+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111100, %11111111, %11111111, %11111111, %00111111
         db   %11100000, %00000000, %00000000, %01100000, %00000111
         db   %11111100, %11111111, %11100111, %11111111, %00111111
         db   121, 0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   12, 61+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111100, %11111111, %11100111, %11111111, %00111111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   138, 0
         db   ((item_lantern_on or wall_mask_flash) or wall_mask_crush)
         db   65, 27+topoffset
         db   0
         db   ((0 or wall_mask_flash) or wall_mask_crush)
         db   ((0 or wall_mask_flash) or wall_mask_crush)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %00110000, %00011111, %11110000, %00000000, %00111111
         db   %11111111, %10000000, %00000000, %00000000, %11111111
         db   144, 176
         db   (item_lantern_on or item_bottm_water)
         db   41, 27+topoffset
         db   0
         db   (item_bat or item_bottm_water)
         db   44, 61+topoffset
         db   4
         db   (item_moth or item_bottm_water)
         db   19, 97+topoffset
         db   227
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11100000, %00000000, %00111100, %00000000, %00001111
         db   0, 202
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   20, 59+topoffset
         db   148
         db   ((item_snake or wall_mask_flash) or item_bottm_water)
         db   44, 99+topoffset
         db   0
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %01111000, %11000000, %00000011, %11000000
         db   %11100000, %00000001, %11111111, %00000000, %00001111
         db   0, 219
         db   (item_snake or item_bottm_water)
         db   26, 63+topoffset
         db   0
         db   (item_snake or item_bottm_water)
         db   48, 101+topoffset
         db   0
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00001111, %11111111, %11110000, %00000000
         db   %11111000, %00000000, %00000000, %00000000, %00011111
         db   0, 236
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   63, 125+topoffset
         db   16
         db   ((item_snake or wall_mask_flash) or item_bottm_water)
         db   56, 63+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   26, 97+topoffset
         db   0
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   0, 253
         db   item_moth
         db   30, 59+topoffset
         db   244
         db   0
         db   0
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11100001, %11111111, %10000111, %11111111
         db   0, 14
         db   (item_spider or item_bottm_water)
         db   38, 63+topoffset
         db   0
         db   (item_bat or item_bottm_water)
         db   23, 95+topoffset
         db   0
         db   (item_miner_rt or item_bottm_water)
         db   7, 79+topoffset
         db   0
;
;************ LEVEL 16
;
level16  db   16
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111100, %11111111, %11000011, %11111111, %00111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111100, %11111111, %11000011, %11111111, %00111111
         db   %11000000, %00000000, %11111111, %00000000, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   0, 2
         db   (item_lantern_on or wall_mask_flash)
         db   13, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   70, 59+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %01111110, %00000000, %00000011
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   3, 16
         db   (item_moth or wall_mask_flash)
         db   20, 61+topoffset
         db   116
         db   (item_moth or wall_mask_flash)
         db   27, 99+topoffset
         db   131
         db   (0 or wall_mask_flash)
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   %11111111, %11111100, %00000000, %00111111, %11111111
         db   %11111111, %11110000, %00000000, %00001111, %11111111
         db   36, 0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   42, 61+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   38, 105+topoffset
         db   0
         db   %11111111, %11110000, %00000000, %00001111, %11111111
         db   %11110000, %11000000, %00111100, %00000000, %00001111
         db   %11111001, %11111111, %11111111, %11111111, %10011111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   53, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   22, 59+topoffset
         db   4
         db   (item_snake or wall_mask_flash)
         db   66, 101+topoffset
         db   0
         db   %11111001, %11111111, %11111111, %11111111, %10011111
         db   %11110000, %00110000, %01111110, %00000000, %00001111
         db   %11111111, %11111000, %00000000, %00011111, %11111111
         db   70, 0
         db   (item_lantern_on or wall_mask_flash)
         db   11, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   28, 59+topoffset
         db   4
         db   (item_moth or wall_mask_flash)
         db   29, 103+topoffset
         db   243
         db   %11111111, %11111000, %00000000, %00011111, %11111111
         db   %11111111, %11111100, %11111111, %00111111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   51, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   32, 99+topoffset
         db   244
         db   (0 or wall_mask_flash)
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   104, 0
         db   ((item_lantern_on or wall_mask_flash) or wall_mask_crush)
         db   71, 27+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or wall_mask_crush)
         db   48, 99+topoffset
         db   0
         db   ((0 or wall_mask_flash) or wall_mask_crush)
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   %11111111, %11110011, %11100111, %11001111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   121, 0
         db   (item_lantern_on or wall_mask_flash)
         db   71, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   48, 101+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11111111, %00000000, %00000000, %00000000, %11111111
         db   138, 0
         db   ((item_lantern_on or wall_mask_flash) or wall_mask_crush)
         db   71, 27+topoffset
         db   0
         db   ((item_bat or wall_mask_flash) or wall_mask_crush)
         db   48, 101+topoffset
         db   4
         db   ((0 or wall_mask_flash) or wall_mask_crush)
         db   %11111111, %00000000, %00000000, %00000000, %11111111
         db   %11100000, %00000000, %00111100, %00000000, %00000000
         db   %11111000, %00000000, %00000000, %00000000, %00111111
         db   144, 11
         db   ((item_lantern_on or wall_mask_flash) or item_bottm_water)
         db   61, 27+topoffset
         db   0
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   50, 61+topoffset
         db   244
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   38, 97+topoffset
         db   4
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00011111, %11111111, %11111000, %00000000
         db   %11111000, %00000000, %00000000, %00000000, %00111111
         db   0, 172
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   12, 125+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   14, 61+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   48, 99+topoffset
         db   0
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11111100, %00000000, %00111100, %00000000, %01111111
         db   0, 189
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   14, 99+topoffset
         db   244
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   55, 65+topoffset
         db   211
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %01111111, %11111111, %11111110, %00011000
         db   %11111000, %00000000, %00000000, %00000000, %00111111
         db   0, 206
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   12, 125+topoffset
         db   0
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   14, 59+topoffset
         db   4
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   38, 99+topoffset
         db   0
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11111110, %00000000, %01111110, %00000000, %11111111
         db   0, 223
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   16, 61+topoffset
         db   244
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   46, 101+topoffset
         db   211
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00111100, %00000000, %00000011
         db   %11111111, %11100000, %00000000, %00000111, %11111111
         db   0, 224
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   28, 63+topoffset
         db   0
         db   ((item_miner_lt or wall_mask_flash) or item_bottm_water)
         db   66, 79+topoffset
         db   0
         db   ((0 or wall_mask_flash) or item_bottm_water)
;
;************ LEVEL 17
;
level17  db   17
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11111110, %00000000, %00000000, %11000000, %01111111
         db   %11100000, %00001111, %11111111, %11110000, %00000111
         db   2, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   20, 59+topoffset
         db   244
         db   (item_bat or wall_mask_flash)
         db   66, 101+topoffset
         db   4
         db   %11100000, %00001111, %11111111, %11110000, %00000111
         db   %11111000, %00111111, %11111111, %11111100, %00011111
         db   %11111110, %00000000, %00000000, %00000000, %01111111
         db   19, 0
         db   (item_lantern_on or wall_mask_flash)
         db   21, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   66, 61+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   14, 99+topoffset
         db   4
         db   %11111110, %00000000, %00000000, %00000000, %01111111
         db   %11111111, %11100000, %00000000, %00000111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   36, 0
         db   item_lantern_on
         db   63, 27+topoffset
         db   0
         db   item_moth
         db   34, 61+topoffset
         db   244
         db   item_moth
         db   42, 101+topoffset
         db   244
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   %11111111, %11111000, %00000000, %00011111, %11111111
         db   %11111111, %11100000, %00000000, %00000111, %11111111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   71, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   30, 63+topoffset
         db   244
         db   (item_moth or wall_mask_flash)
         db   32, 101+topoffset
         db   211
         db   %11111111, %11100000, %00000000, %00000111, %11111111
         db   %11111111, %11111000, %00000000, %00011111, %11111111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   70, 0
         db   (item_lantern_on or wall_mask_flash)
         db   55, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   38, 63+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11100000, %00000000, %00000000, %01100000, %00001111
         db   %11111001, %11111111, %11111111, %11111111, %00111111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   39, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   23, 63+topoffset
         db   179
         db   (item_bat or wall_mask_flash)
         db   10, 97+topoffset
         db   4
         db   %11111001, %11111111, %11111111, %11111111, %00111111
         db   %00000000, %00000000, %00000000, %00000000, %00001111
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   96, 128
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   46, 61+topoffset
         db   244
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %11111100, %00000000, %00000000, %01111000, %00000000
         db   %11110000, %00000000, %00000000, %00000000, %00111111
         db   9, 7
         db   (item_spider or wall_mask_flash)
         db   61, 61+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   47, 97+topoffset
         db   244
         db   (0 or wall_mask_flash)
         db   %11110000, %00000000, %00000000, %00000000, %00111111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11111111, %11110000, %00000000, %00001111, %11111111
         db   138, 0
         db   ((item_lantern_on or wall_mask_flash) or wall_mask_crush)
         db   65, 27+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or wall_mask_crush)
         db   31, 97+topoffset
         db   0
         db   ((0 or wall_mask_flash) or wall_mask_crush)
         db   %11111111, %11110000, %00000000, %00001111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000111
         db   %11110001, %11111111, %11111111, %11111110, %00111111
         db   144, 176
         db   (item_lantern_on or item_bottm_water)
         db   53, 27+topoffset
         db   0
         db   (item_snake or item_bottm_water)
         db   8, 103+topoffset
         db   0
         db   (item_moth or item_bottm_water)
         db   29, 63+topoffset
         db   180
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00011000, %00011111, %11111111, %11111000, %00000000
         db   %11111100, %00000000, %00000000, %00000000, %00001111
         db   0, 202
         db   (item_tentacle or item_bottm_water)
         db   65, 119+topoffset
         db   0
         db   (item_spider or item_bottm_water)
         db   64, 63+topoffset
         db   0
         db   (item_moth or item_bottm_water)
         db   24, 95+topoffset
         db   115
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11111100, %00000000, %00111100, %00000000, %00111111
         db   0, 219
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   14, 59+topoffset
         db   244
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   49, 99+topoffset
         db   4
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11111100, %00000000, %00111100, %00000000, %00111111
         db   0, 236
         db   (item_bat or item_bottm_water)
         db   28, 59+topoffset
         db   4
         db   (item_snake or item_bottm_water)
         db   44, 103+topoffset
         db   0
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00011111, %11111111, %11111000, %00000000
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   0, 253
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   61, 125+topoffset
         db   16
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   11, 61+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   20, 99+topoffset
         db   0
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %11000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %00000000, %00000000, %00000000, %01111111
         db   0, 14
         db   (item_miner_rt or item_bottm_water)
         db   10, 79+topoffset
         db   0
         db   (item_spider or item_bottm_water)
         db   61, 99+topoffset
         db   0
         db   (item_moth or item_bottm_water)
         db   23, 61+topoffset
         db   244
;
;************ LEVEL 18
;
level18  db   18
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11110000, %00000000, %00000000, %11000000, %00001111
         db   %11111100, %11001111, %11111111, %11110011, %00111111
         db   2, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   23, 61+topoffset
         db   179
         db   (item_bat or wall_mask_flash)
         db   12, 95+topoffset
         db   4
         db   %11111100, %11001111, %11111111, %11110011, %00111111
         db   %11110000, %01111111, %11111111, %11111110, %00001111
         db   %11111110, %00001111, %11111111, %11110000, %01111111
         db   19, 0
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_snake or wall_mask_flash)
         db   56, 103+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   68, 61+topoffset
         db   0
         db   %11111110, %00001111, %11111111, %11110000, %01111111
         db   %11110000, %00000000, %00000000, %11000000, %00001111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   36, 0
         db   (item_lantern_on or wall_mask_flash)
         db   63, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   27, 61+topoffset
         db   244
         db   (item_bat or wall_mask_flash)
         db   40, 99+topoffset
         db   4
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11110000, %00000000, %00000000, %00110000, %00001111
         db   %11111100, %11111111, %11111111, %11111111, %00111111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   41, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   19, 63+topoffset
         db   244
         db   (item_snake or wall_mask_flash)
         db   12, 101+topoffset
         db   0
         db   %11111100, %11111111, %11111111, %11111111, %00111111
         db   %11110000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   64, 6
         db   (item_lantern_on or wall_mask_flash)
         db   65, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   46, 63+topoffset
         db   244
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000011
         db   %11111110, %00000000, %01111110, %00000000, %01111111
         db   7, 80
         db   (item_moth or wall_mask_flash)
         db   18, 57+topoffset
         db   179
         db   (item_moth or wall_mask_flash)
         db   18, 97+topoffset
         db   179
         db   (0 or wall_mask_flash)
         db   %11111110, %00000000, %01111110, %00000000, %01111111
         db   %11111111, %11110000, %00000000, %00001111, %11111111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   104, 0
         db   (item_lantern_on or wall_mask_flash)
         db   31, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   38, 59+topoffset
         db   4
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   121, 0
         db   ((item_lantern_on or wall_mask_flash) or wall_mask_crush)
         db   39, 27+topoffset
         db   0
         db   ((0 or wall_mask_flash) or wall_mask_crush)
         db   ((0 or wall_mask_flash) or wall_mask_crush)
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11110000, %00000011, %10000001, %11000000, %00001111
         db   %11111001, %11110011, %11100111, %11001111, %10011111
         db   138, 0
         db   (item_lantern_on or wall_mask_flash)
         db   39, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   24, 95+topoffset
         db   4
         db   (item_moth or wall_mask_flash)
         db   57, 61+topoffset
         db   148
         db   %11111001, %11110011, %11100111, %11001111, %10011111
         db   %11110000, %11100000, %00000000, %00000111, %00000000
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   144, 11
         db   (item_lantern_on or wall_mask_flash)
         db   39, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   43, 61+topoffset
         db   148
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00001111, %11111111, %11110000, %00110000
         db   %11111110, %00000000, %00000000, %00000000, %01111111
         db   0, 172
         db   (item_tentacle or item_bottm_water)
         db   15, 119+topoffset
         db   0
         db   (item_spider or item_bottm_water)
         db   19, 59+topoffset
         db   0
         db   (item_moth or item_bottm_water)
         db   47, 97+topoffset
         db   163
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00001111, %11111111, %11110000, %00000000
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   0, 189
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   14, 125+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   16, 61+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   38, 97+topoffset
         db   0
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11111100, %00000000, %00111100, %00000000, %00111111
         db   0, 206
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   26, 97+topoffset
         db   4
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   48, 63+topoffset
         db   0
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00000000, %00000000, %00000000
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   0, 223
         db   (item_moth or item_bottm_water)
         db   30, 97+topoffset
         db   244
         db   (item_spider or item_bottm_water)
         db   66, 61+topoffset
         db   0
         db   (0 or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00111100, %00000000, %00000011
         db   %11111111, %00000000, %00000000, %00000000, %11111111
         db   0, 224
         db   ((item_miner_lt or wall_mask_flash) or item_bottm_water)
         db   67, 79+topoffset
         db   0
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   21, 61+topoffset
         db   115
         db   ((0 or wall_mask_flash) or item_bottm_water)
;
;************ LEVEL 19
;
level19  db   19
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11110000, %00000000, %00000001, %10000000, %00001111
         db   %11111111, %11001111, %11111111, %11110011, %11111111
         db   2, 0
         db   (item_lantern_on or wall_mask_flash)
         db   39, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   20, 63+topoffset
         db   243
         db   (0 or wall_mask_flash)
         db   %11111111, %11001111, %11111111, %11110011, %11111111
         db   %11110000, %00000000, %01111111, %11100000, %00001111
         db   %11111111, %11111110, %00000000, %01111111, %11111111
         db   19, 0
         db   (item_lantern_on or wall_mask_flash)
         db   57, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   54, 63+topoffset
         db   212
         db   (item_moth or wall_mask_flash)
         db   34, 101+topoffset
         db   131
         db   %11111111, %11111110, %00000000, %01111111, %11111111
         db   %11111111, %00000000, %00000000, %00110000, %11111111
         db   %11110000, %00011111, %11111111, %11111000, %00001111
         db   36, 0
         db   (item_lantern_on or wall_mask_flash)
         db   47, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   16, 57+topoffset
         db   4
         db   (item_moth or wall_mask_flash)
         db   62, 99+topoffset
         db   83
         db   %11110000, %00011111, %11111111, %11111000, %00001111
         db   %11111111, %11000011, %11111111, %11111100, %00111111
         db   %11110000, %01111111, %11111111, %11111110, %00011111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   19, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   64, 59+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   66, 99+topoffset
         db   4
         db   %11110000, %01111111, %11111111, %11111110, %00011111
         db   %11111110, %00000000, %00000011, %00000000, %01111111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   70, 0
         db   (item_lantern_on or wall_mask_flash)
         db   67, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   38, 61+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   87, 0
         db   ((item_lantern_on or wall_mask_flash) or wall_mask_crush)
         db   39, 27+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or wall_mask_crush)
         db   28, 99+topoffset
         db   0
         db   ((0 or wall_mask_flash) or wall_mask_crush)
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   %11111111, %00000000, %00111111, %11111111, %00000011
         db   %11111111, %10000000, %00000000, %00000001, %11111111
         db   104, 0
         db   item_lantern_on
         db   57, 27+topoffset
         db   0
         db   item_moth
         db   19, 61+topoffset
         db   131
         db   item_bat
         db   19, 97+topoffset
         db   4
         db   %11111111, %10000000, %00000000, %00000001, %11111111
         db   %11111111, %11111111, %11000011, %11111111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   121, 0
         db   (item_lantern_on or wall_mask_flash)
         db   59, 27+topoffset
         db   0
         db   (item_snake or wall_mask_flash)
         db   36, 63+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   29, 97+topoffset
         db   115
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   %11111111, %11111111, %00111100, %11111111, %11111111
         db   %11111110, %00000000, %00000000, %00000000, %01111111
         db   138, 0
         db   (item_lantern_on or wall_mask_flash)
         db   71, 27+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   44, 61+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   25, 97+topoffset
         db   4
         db   %11111110, %00000000, %00000000, %00000000, %01111111
         db   %00000011, %11111111, %10000001, %11111111, %11000011
         db   %11110000, %00000000, %00000000, %00000000, %00001111
         db   144, 176
         db   (item_lantern_on or item_bottm_water)
         db   63, 27+topoffset
         db   0
         db   (item_snake or item_bottm_water)
         db   34, 65+topoffset
         db   0
         db   (item_spider or item_bottm_water)
         db   59, 97+topoffset
         db   0
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00110000, %00011111, %11111111, %11111000, %00000000
         db   %11111000, %00000000, %00000000, %00000000, %00011111
         db   0, 202
         db   (item_tentacle or item_bottm_water)
         db   63, 119+topoffset
         db   0
         db   (item_moth or item_bottm_water)
         db   16, 95+topoffset
         db   243
         db   (item_bat or item_bottm_water)
         db   63, 59+topoffset
         db   4
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %01111111, %11111111, %11111110, %00000000
         db   %11110000, %00000000, %00000000, %00000000, %00001111
         db   0, 219
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   65, 125+topoffset
         db   16
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   38, 99+topoffset
         db   0
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   6, 63+topoffset
         db   4
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00011000, %00000000, %00000000
         db   %11111110, %00000000, %00111100, %00000000, %01111111
         db   0, 236
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   20, 59+topoffset
         db   211
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   51, 101+topoffset
         db   0
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00110000, %00000000, %00111100, %00000000, %00000000
         db   %11111000, %00000000, %00000000, %00000000, %00111111
         db   0, 253
         db   ((item_tentacle or wall_mask_flash) or item_bottm_water)
         db   60, 119+topoffset
         db   0
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   15, 61+topoffset
         db   0
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %11000000, %00000000, %00111100, %00000000, %00000000
         db   %11111111, %11100000, %00000000, %00000111, %11111111
         db   0, 14
         db   ((item_miner_rt or wall_mask_flash) or item_bottm_water)
         db   9, 79+topoffset
         db   0
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   55, 63+topoffset
         db   211
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   54, 101+topoffset
         db   4
;
;************ LEVEL 20
;
level20  db   20
         db   16
         db   %11111100, %00000001, %10000000, %00000000, %00111111
         db   %11110000, %00000001, %10000000, %00000000, %00001111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   1, 0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11110000, %00000000, %00000001, %10000000, %00001111
         db   %11111100, %00001111, %11111111, %11110000, %00111111
         db   2, 0
         db   (item_lantern_on or wall_mask_flash)
         db   39, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   20, 63+topoffset
         db   244
         db   (item_spider or wall_mask_flash)
         db   64, 99+topoffset
         db   0
         db   %11111100, %00001111, %11111111, %11110000, %00111111
         db   %11111111, %00111111, %11111111, %11111100, %11111111
         db   %11110000, %00000000, %00000000, %00000000, %00001111
         db   19, 0
         db   item_lantern_on
         db   65, 27+topoffset
         db   0
         db   item_bat
         db   16, 57+topoffset
         db   4
         db   item_moth
         db   46, 99+topoffset
         db   180
         db   %11110000, %00000000, %00000000, %00000000, %00001111
         db   %11111111, %00111111, %11111111, %11111100, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   36, 0
         db   (item_lantern_on or wall_mask_flash)
         db   69, 27+topoffset
         db   0
         db   (item_snake or wall_mask_flash)
         db   60, 63+topoffset
         db   0
         db   (item_spider or wall_mask_flash)
         db   21, 103+topoffset
         db   0
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   %11111111, %11111000, %00000000, %00011111, %11111111
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   53, 0
         db   (item_lantern_on or wall_mask_flash)
         db   71, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   30, 61+topoffset
         db   244
         db   (item_moth or wall_mask_flash)
         db   30, 103+topoffset
         db   244
         db   %11100000, %00000000, %00000000, %00000000, %00000111
         db   %11111111, %11111111, %11100111, %11111111, %11111111
         db   %11111000, %00000000, %00000000, %00000000, %00011111
         db   70, 0
         db   ((item_lantern_on or wall_mask_flash) or wall_mask_crush)
         db   71, 27+topoffset
         db   0
         db   ((item_moth or wall_mask_flash) or wall_mask_crush)
         db   21, 99+topoffset
         db   211
         db   ((0 or wall_mask_flash) or wall_mask_crush)
         db   %11111000, %00000000, %00000000, %00000000, %00011111
         db   %11100000, %00001111, %11111111, %11110000, %00000111
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   87, 0
         db   (item_lantern_on or wall_mask_flash)
         db   67, 27+topoffset
         db   0
         db   (item_moth or wall_mask_flash)
         db   10, 61+topoffset
         db   115
         db   (item_spider or wall_mask_flash)
         db   56, 101+topoffset
         db   0
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   %11111000, %00000000, %11111111, %00000000, %00011111
         db   104, 0
         db   (item_lantern_on or wall_mask_flash)
         db   57, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   24, 59+topoffset
         db   4
         db   (item_moth or wall_mask_flash)
         db   54, 101+topoffset
         db   179
         db   %11111000, %00000000, %11111111, %00000000, %00011111
         db   %11100000, %00000011, %11111111, %11000000, %00000111
         db   %11111110, %00000000, %11111111, %00000000, %01111111
         db   121, 0
         db   (item_lantern_on or wall_mask_flash)
         db   67, 27+topoffset
         db   0
         db   (item_bat or wall_mask_flash)
         db   24, 59+topoffset
         db   4
         db   (item_moth or wall_mask_flash)
         db   55, 103+topoffset
         db   99
         db   %11111110, %00000000, %11111111, %00000000, %01111111
         db   %11111111, %11110011, %11111111, %11001111, %11111111
         db   %11111000, %00000000, %11111111, %00000000, %00011111
         db   138, 0
         db   (item_spider or wall_mask_flash)
         db   56, 101+topoffset
         db   0
         db   (0 or wall_mask_flash)
         db   (0 or wall_mask_flash)
         db   %11111000, %00000000, %11111111, %00000000, %00011111
         db   %11110000, %11111111, %11111111, %11111111, %00000000
         db   %11111000, %00000000, %00000000, %00000000, %00011111
         db   144, 11
         db   (item_lantern_on or item_bottm_water)
         db   67, 27+topoffset
         db   0
         db   (item_spider or item_bottm_water)
         db   69, 61+topoffset
         db   0
         db   (item_moth or item_bottm_water)
         db   41, 99+topoffset
         db   243
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00111111, %11111111, %11111000, %00011000
         db   %11111000, %00000000, %00000000, %00000000, %00111111
         db   0, 172
         db   ((item_raft or wall_mask_flash) or item_bottm_water)
         db   12, 125+topoffset
         db   0
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   16, 61+topoffset
         db   4
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   38, 99+topoffset
         db   0
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00111100, %00000000, %00011000
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   0, 189
         db   ((item_tentacle or wall_mask_flash) or item_bottm_water)
         db   13, 119+topoffset
         db   0
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   13, 61+topoffset
         db   243
         db   ((item_spider or wall_mask_flash) or item_bottm_water)
         db   58, 97+topoffset
         db   0
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000001, %11111111, %10000000, %00011000
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   0, 206
         db   ((item_bat or wall_mask_flash) or item_bottm_water)
         db   15, 63+topoffset
         db   4
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   56, 101+topoffset
         db   115
         db   ((0 or wall_mask_flash) or item_bottm_water)
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00111100, %00000000, %00000000
         db   %11111100, %00000000, %00000000, %00000000, %00111111
         db   0, 223
         db   ((item_tentacle or wall_mask_flash) or item_bottm_water)
         db   13, 119+topoffset
         db   0
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   20, 61+topoffset
         db   163
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   56, 97+topoffset
         db   115
         db   %11111111, %11111111, %11111111, %11111111, %11111111
         db   %00000000, %00000000, %00111100, %00000000, %00000011
         db   %11111111, %11000000, %00000000, %00000011, %11111111
         db   0, 224
         db   ((item_moth or wall_mask_flash) or item_bottm_water)
         db   15, 61+topoffset
         db   243
         db   ((item_miner_lt or wall_mask_flash) or item_bottm_water)
         db   67, 79+topoffset
         db   0
         db   ((0 or wall_mask_flash) or item_bottm_water)
