--------------------------------------------------------------
--                  Sonic Destination Game                  --
--                       Version 0.001                      --
--                                                          --
--                 Functional Specifications                --
--                         GAME-0001                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
Draw Sonic the Hedgehog sprite (from Sonic 1, Sega Genesis) in Workspace,
standing on the line.

                           Features
                           --------
- [X] Sonic is drawn to screen
- [X] Sonic is positioned so that he is standing on the line
- [ ] Sonic is drawn at the proper scale
- [ ] Sonic is centered horizontally

--]]

--------------------------------------------------------------
--                       Local Variables                    --
--------------------------------------------------------------

local GRAFX               = love.graphics
local COLOR               = requireRelative("constants/colors")

local SONIC_IMAGE         = GRAFX.newImage(relativePath("resources/images/spriteSheets/sonic1/sonic1.png"))
local SONIC_STANDING_RECT = { x = 43, y = 257, w = 32, h = 40 }
local SONIC_QUAD          = love.graphics.newQuad(
                                SONIC_STANDING_RECT.x,  SONIC_STANDING_RECT.y,
                                SONIC_STANDING_RECT.w,  SONIC_STANDING_RECT.h,
                                SONIC_IMAGE:getWidth(), SONIC_IMAGE:getHeight())

local sonicX, sonicY      = 500, 536

local WORKSPACE           = {
    draw = function(self)
        self:drawBackground()
        self:drawHorizontalLine()
    end,

    drawBackground = function(self)
        GRAFX.clear(COLOR.GREEN)
    end,

    drawHorizontalLine = function(self)
        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.setLineWidth(3)
        GRAFX.line(0, GRAFX.getHeight() * 3 / 4, GRAFX.getWidth(), GRAFX.getHeight() * 3 / 4)
    end,
}

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

local drawSonic = function()
    GRAFX.setColor(COLOR.PURE_WHITE)
    GRAFX.draw(SONIC_IMAGE, SONIC_QUAD, sonicX, sonicY, 0, 3, 3)
end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.draw()
    WORKSPACE:draw()
    drawSonic()
end

function love.keypressed(key)
    if     key == "down"  then sonicY = sonicY + 1
    elseif key == "up"    then sonicY = sonicY - 1
    elseif key == "space" then print("Sonic Y = " .. sonicY) end
end

--[[
                             ...,?77??!~~~~!???77?<~.... 
                        ..?7`                           `7!.. 
                    .,=`          ..~7^`   I                  ?1. 
       ........  ..^            ?`  ..?7!1 .               ...??7 
      .        .7`        .,777.. .I.    . .!          .,7! 
      ..     .?         .^      .l   ?i. . .`       .,^ 
       b    .!        .= .?7???7~.     .>r .      .= 
       .,.?4         , .^         1        `     4... 
        J   ^         ,            5       `         ?<. 
       .%.7;         .`     .,     .;                   .=. 
       .+^ .,       .%      MML     F       .,             ?, 
        P   ,,      J      .MMN     F        6               4. 
        l    d,    ,       .MMM!   .t        ..               ,, 
        ,    JMa..`         MMM`   .         .!                .; 
         r   .M#            .M#   .%  .      .~                 ., 
       dMMMNJ..!                 .P7!  .>    .         .         ,, 
       .WMMMMMm  ?^..       ..,?! ..    ..   ,  Z7`        `?^..  ,, 
          ?THB3       ?77?!        .Yr  .   .!   ?,              ?^C 
            ?,                   .,^.` .%  .^      5. 
              7,          .....?7     .^  ,`        ?. 
                `<.                 .= .`'           1 
                ....dn... ... ...,7..J=!7,           ., 
             ..=     G.,7  ..,o..  .?    J.           F 
           .J.  .^ ,,,t  ,^        ?^.  .^  `?~.      F 
          r %J. $    5r J             ,r.1      .=.  .% 
          r .77=?4.    ``,     l ., 1  .. <.       4., 
          .$..    .X..   .n..  ., J. r .`  J.       `' 
        .?`  .5        `` .%   .% .' L.'    t 
        ,. ..1JL          .,   J .$.?`      . 
                1.          .=` ` .J7??7<.. .; 
                 JS..    ..^      L        7.: 
                   `> ..       J.  4. 
                    +   r `t   r ~=..G. 
                    =   $  ,.  J 
                    2   r   t  .; 
              .,7!  r   t`7~..  j.. 
              j   7~L...$=.?7r   r ;?1. 
               8.      .=    j ..,^   .. 
              r        G              . 
            .,7,        j,           .>=. 
         .J??,  `T....... %             .. 
      ..^     <.  ~.    ,.             .D 
    .?`        1   L     .7.........?Ti..l 
   ,`           L  .    .%    .`!       `j, 
 .^             .  ..   .`   .^  .?7!?7+. 1 
.`              .  .`..`7.  .^  ,`      .i.; 
.7<..........~<<3?7!`    4. r  `          G% 
                          J.` .!           % 
                            JiJ           .` 
                              .1.         J 
                                 ?1.     .'         
                                     7<..%
    
    

                                        








                    Sonic ASCII art credits
                    -----------------------
    "ASCII Art of Sonic"
    posted by put-mutt on
    https://www.reddit.com/r/SonicTheHedgehog/comments/fpeyy4/ascii_art_of_sonic/?rdt=43749
    ---------------------------------------------------------------------------------------
    
--]]
