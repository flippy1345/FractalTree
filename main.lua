local screenWidth, screenHeight = 0, 0
local center = {}
local growLenght = 100
local bend = 0

function map(currentRange, minRange, maxRange, minReturnRange, maxReturnRange)
  return (currentRange * ((maxReturnRange - minReturnRange) / (maxRange - minRange)))
end

function branch(startPosX, startPosY, lenght, startAngle, bend, side)
  if lenght > 2 then
    local rad = math.rad(startAngle)
    local endPosX = startPosX + lenght * math.cos(rad)
    local endPosY = startPosY + lenght * math.sin(rad)
    local color = {
      ['r'] = map(startPosX, center.width - startPosX, center.width + startPosX, 0, 255),
      ['g'] = map(startPosY, center.height - startPosY, center.height + startPosY, 0, 20),
      ['b'] = map(100 - lenght, 0, 100, 0, 150)
    }
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.setLineWidth(lenght * 0.1)
    love.graphics.line(startPosX, startPosY, endPosX, endPosY)
    startAngle = startAngle + 35
    lenght = lenght - (lenght * 0.3)
    branch(endPosX, endPosY, lenght, startAngle + bend, bend)-- right
    branch(endPosX, endPosY, lenght, startAngle - 70 + bend, bend)-- left
  end
end

function drawButton(xI, yI, width, height, onPressFunction)
  love.graphics.setColor(200, 160, 200)
  love.graphics.rectangle("fill", xI, yI, width, height)

  function love.touchpressed(id, x, y, dx, dy, pressure)
    if x >= xI and y >= yI and x <= width and y <= height then
      onPressFunction()
    end
  end
  function love.mousepressed(x, y, button, isTouch)
    if x >= xI and y >= yI and x <= width and y <= height then
      onPressFunction()
    end
  end
end



function love.load(arg)
  love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
  deltaTime = dt
  love.window.setTitle("FractalTree - "..love.timer.getFPS().."FPS")
  screenWidth, screenHeight = love.graphics.getDimensions()
  center = {['width'] = screenWidth * 0.5, ['height'] = screenHeight * 0.5 }
end

function love.keypressed(key, scancode, isrepeat)
  if key == 'right' then
    if isrepeat then
      bend = bend + deltaTime * 60
    else
      bend = bend + deltaTime * 10
    end
  elseif key == 'left' then
    if isrepeat then
      bend = bend - deltaTime * 60
    else
      bend = bend - deltaTime * 10
    end
  elseif key == 'up' then
    if isrepeat then
      growLenght = growLenght + deltaTime * 60
    else
      growLenght = growLenght + deltaTime * 10
    end
  elseif key == 'down' then
    if isrepeat then
      growLenght = growLenght - deltaTime * 60
    else
      growLenght = growLenght - deltaTime * 10
    end
  elseif key == 'space' then
    growLenght = 100
    bend = 0
  elseif key == 'r' then
    growLenght = math.random(1, 200)
    bend = math.random(-100, 100)
  end
end


function love.draw()
  branch(center.width, center.height + 250, growLenght, - 90, bend, 0)
  drawButton(20, 20, 150, 150,
    function()
      growLenght = math.random(1, 200)
      bend = math.random(-100, 100)
    end
  )
end
