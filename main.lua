local screenWidth, screenHeight = 0, 0
local center = {}
local growLenght = 0
local bend = 0

function map(currentRange, minRange, maxRange, minReturnRange, maxReturnRange)
  return (currentRange * ((maxReturnRange - minReturnRange) / (maxRange - minRange)))
end

function branch(startPosX, startPosY, lenght, startAngle, bend)
  if lenght > 2 then
    local rad = math.rad(startAngle)
    local endPosX = startPosX + lenght * math.cos(rad)
    local endPosY = startPosY + lenght * math.sin(rad)
    local color = {
      ['r'] = map(startPosX, center.width-200, center.width+200, 0, 255),
      ['g'] = 0,
      ['b'] = map(100-lenght, 0, 100, 0, 100)
    }
    --print("color.r: "..color.r)
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.line(startPosX, startPosY, endPosX, endPosY)
    startAngle = startAngle + 35
    lenght = lenght - (lenght * 0.3)
    branch(endPosX, endPosY, lenght, startAngle, bend)
    branch(endPosX, endPosY, lenght, startAngle - 70 + bend, bend)
  end
end

function love.load(arg)

end

function love.update(dt)
  deltaTime = dt
  growLenght = growLenght + dt * 4
  if growLenght >= 200 then
    growLenght = 200
  end
  love.window.setTitle("FractalTree - "..love.timer.getFPS().."FPS")
  screenWidth, screenHeight = love.graphics.getDimensions()
  center = {['width'] = screenWidth * 0.5, ['height'] = screenHeight * 0.5 }
  --print("mouseX: "..love.mouse.getX(), "map: "..map(love.mouse.getX(), 0, screenWidth, 0, 255))
end
function love.keypressed(key, scancode, isrepeat)
  if key == 'right' then
    bend = bend+deltaTime*20
  end
end

function love.draw()
  branch(center.width, center.height + 250, 100, - 90, bend)
end
