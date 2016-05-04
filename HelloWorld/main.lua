--print( "Hello World!" )
--local myTextObject = display.newText( "Hello World!", 160, 240, "Arial", 60 )
--myTextObject:setFillColor( 1, 0, 0 )

function screenTap()
    local r = math.random( 0, 100 )
    local g = math.random( 0, 100 )
    local b = math.random( 0, 100 )
    myTextObject:setFillColor( r/100, g/100, b/100 )
end

display.currentStage:addEventListener( "tap", screenTap )

local physics = require( "physics" )
physics.start()
local mons1 = display.newImage( "Mons 1.png" )
mons1.x = 150; mons1.y = 150;
mons1.rotation = 5;
mons1:scale(0.2, 0.2);
physics.addBody( mons1,  "static", { friction=0.5, bounce=0.3 } )


local mons2 = display.newImage( "Mons 2.png" )
mons2.x = 150; mons2.y = 150;
mons2:scale(0.2, 0.2)
mons2.isVisible = false;
physics.addBody( mons2, "static", { friction=0.5, bounce=0.3 } )

--print( display.pixelWidth / display.actualContentWidth )

local function handleSwipe( event )
    if ( event.phase == "moved" ) then
        local dX = event.x - event.xStart
        --print( event.x, event.xStart, dX )
        if ( dX > 10 ) then
            --swipe right
            local spot = RIGHT
            if ( event.target.x == LEFT ) then
                spot = CENTER
            end
            mons1.isVisible = true;
            mons2.isVisible = false;
            transition.to( event.target, { time=500, x=spot } )
        elseif ( dX < -10 ) then
            --swipe left
            local spot = LEFT
            if ( event.target.x == RIGHT ) then
                spot = CENTER
            end
            mons1.isVisible = false;
            mons2.isVisible = true;
            transition.to( event.target, { time=500, x=spot } )
        end
    end
    return true
end
 
display.currentStage:addEventListener( "touch", handleSwipe )
