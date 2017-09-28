local screenWidth, screenHeight = 0, 0
local center = {}
local growLenght = 0

function map(currentRange, minRange, maxRange, minReturnRange, maxReturnRange)
  return (currentRange * ((maxReturnRange - minReturnRange) / (maxRange - minRange)))
end

function branch(startPosX, startPosY, lenght, startAngle)
  if lenght > 2 then
    local rad = math.rad(startAngle)
    local endPosX = startPosX + lenght * math.cos(rad)
    local endPosY = startPosY + lenght * math.sin(rad)
    local color = {
      ['r'] = map(startPosY, center.height + 250, 250, 0, 200),
      ['g'] = map(lenght, 2, 100, 0, 0),
      ['b'] = map(startPosX, 0, screenWidth, 0, 0)
    }
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.line(startPosX, startPosY, endPosX, endPosY)
    startAngle = startAngle + 35
    lenght = lenght - (lenght * 0.3)
    branch(endPosX, endPosY, lenght, startAngle)
    branch(endPosX, endPosY, lenght, startAngle - 70)
  end
end

function love.load(arg)

end

function love.update(dt)
  growLenght = growLenght + dt * 4
  if growLenght >= 100 then
    growLenght = 100
  end
  love.window.setTitle("FractalTree - "..love.timer.getFPS().."FPS")
  screenWidth, screenHeight = love.graphics.getDimensions()
  center = {['width'] = screenWidth * 0.5, ['height'] = screenHeight * 0.5 }
  print("mouseX: "..love.mouse.getX(), "map: "..map(love.mouse.getX(), 0, screenWidth, 0, 255))
end

function love.draw()
  branch(center.width, center.height + 250, 100, - 90)
end
