--print( "Hello World!" )
--local myTextObject = display.newText( "Hello World!", 160, 240, "Arial", 60 )
--myTextObject:setFillColor( 1, 0, 0 )

-- Monster object
Monster = {}
Monster.__index = Monster
function Monster.create(imageUrl, x, y, isVisible, scaleX, scaleY)
    local monster = {};
    setmetatable(monster, Monster)
    monster.imageUrl = imageUrl
    monster.x = x
    monster.y = y
    monster.isVisible = isVisible
    monster.scaleX = scaleX
    monster.scaleY = scaleY
    return monster
end

function Monster:addPhysical()
    local physical = display.newImage(self.imageUrl);
    physical.x = self.x
    physical.y = self.y
    physical:scale(self.scaleX, self.scaleY)
    physical.isVisible = self.isVisible
    self.physical = physical
end

-- initialize physics
local physics = require( "physics" )
physics.start()

local monsters = {};
-- add all monsters
for i=1,12 do
    local url = string.format('Mons %d.png', i)
    monsters[i] = Monster.create(url, 150, 150, false, 0.2, 0.2) 
    monsters[i]:addPhysical()
    
    physics.addBody(monsters[i].physical, 'static')
end

local index = 1
monsters[index].physical.isVisible = true;

--local mons1 = display.newImage( "Mons 1.png" )
--mons1.x = 150; mons1.y = 150;
--mons1.rotation = 5;
--mons1:scale(0.2, 0.2);
--physics.addBody( mons1,  "static", { friction=0.5, bounce=0.3 } )


--local mons2 = display.newImage( "Mons 2.png" )
--mons2.x = 150; mons2.y = 150;
--mons2:scale(0.2, 0.2)
--mons2.isVisible = false;
--physics.addBody( mons2, "static", { friction=0.5, bounce=0.3 } )

--print( display.pixelWidth / display.actualContentWidth )

local function moveLeft()
    monsters[index].physical.isVisible = false;
    index = index - 1
    if index <= 0 then index = 12 end
    monsters[index].physical.isVisible = true;
end

local function moveRight()
    monsters[index].physical.isVisible = false;
    index = index + 1
    if index == 13 then index = 1 end
    monsters[index].physical.isVisible = true; 
end

local function handleSwipe( event )
    if ( event.phase == "ended" ) then
        local dX = event.x - event.xStart
        --print( event.x, event.xStart, dX )
        if ( dX > 10 ) then
            --swipe right
            local spot = RIGHT
            if ( event.target.x == LEFT ) then
                spot = CENTER
            end
            
            moveLeft();
            --transition.to( event.target, { time=500, x=spot } )
        elseif ( dX < -10 ) then
            --swipe left
            local spot = LEFT
            if ( event.target.x == RIGHT ) then
                spot = CENTER
            end
            
            moveRight()
            --transition.to( event.target, { time=500, x=spot } )
        end
    end
    return true
end
 
display.currentStage:addEventListener( "touch", handleSwipe )

function screenTap()
    --local r = math.random( 0, 100 )
    --local g = math.random( 0, 100 )
    --local b = math.random( 0, 100 )
    moveRight();
    --myTextObject:setFillColor( r/100, g/100, b/100 )
end

display.currentStage:addEventListener( "tap", screenTap )