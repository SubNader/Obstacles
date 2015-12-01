function love.load()
--Loading main files and initializing some variables.
	--Music!
	music=love.audio.newSource("music/music.mp3")
	music:setVolume(0.6)
	music:setLooping(true)
	jumpSound=love.audio.newSource("music/jump.wav", "static")
	jumpSound:setVolume(0.2)
	--The graphics and font
	bg = love.graphics.newImage("textures/bg.png")
	city1=love.graphics.newImage("textures/city1.png")
	city2=love.graphics.newImage("textures/city2.png")
	main = love.graphics.newImage("textures/main.png")
	deadmessage=love.graphics.newImage("textures/deadmessage.png")
	enemy1=love.graphics.newImage("textures/enemy1.png")
	enemy2 = love.graphics.newImage("textures/enemy2.png")
	enemy3 = love.graphics.newImage("textures/enemy3.png")
	font = love.graphics.newFont(30)
	font2 = love.graphics.newFont(60)

	player = { --player's initial position and velocity
        x = 0,
        y = 0,
		velocity = 1,
        image = love.graphics.newImage("textures/you.png")

    }
		gravity = - 1800
		jump = -1100
		xEnemy1=800
		xEnemy2=1200
		xEnemy3=1600
		run1=0
		run2=0
		run3=0
		score=0
		dead=false
		start=false
		xBg=0
		xBg2=800
end

function love.draw()
	--Drawing the objects.

	
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(city1,xBg,0,0,1,1,0,0)
	
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(city2,xBg2,0,0,1,1,0,0)
	
		love.graphics.setColor(255,255,255,255)
	love.graphics.draw(bg,0,0,0,1,1,0,0)
	
	love.graphics.setColor(255,255,255,255)
    love.graphics.draw(player.image, player.x, player.y, 0, 1, 1, 64, 103)
	
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(enemy1,xEnemy1,430,0,1,1,0,0)
	
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(enemy2,xEnemy2,430,0,1,1,0,0)
	
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(enemy3,xEnemy3,430,0,1,1,0,0)
	    
	love.graphics.setFont(font);
	 love.graphics.setColor(6, 185, 195, 255)
    love.graphics.print(score, 410, 40)
	
	if (player.y<0) then
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(deadmessage,0,0,0,1,1,0,0)
		love.graphics.setFont(font);
	 love.graphics.setColor(6, 185, 195, 255)
    love.graphics.print(score, 410, 40)
	end
	if (start==false) then
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(main,0,0,0,1,1,0,0)
	end

	
	
	
end

function love.update(dt)
if start==true then
if dead == false then
	music:play()
	--Limit el shasha w avoiding el player from exceeding the dimensions
   if player.x<64 then
   player.x=64
   end
   if player.x>800 then
   player.x=800
   end
 -- Moving background
xBg=xBg-200*dt
  xBg2=xBg2-200*dt
  if xBg <-800 then
	xBg=0
  end
  if xBg2 < 0 then
	xBg2=800
  end

-- The enemies! Updating el x-position wel score every time an enemy is overcome
   xEnemy1=xEnemy1-125*dt
	if xEnemy1 < -128 then
	xEnemy1 = 800 -- resetting the x-position 3shan yerga3 tani lamma y3adi el dimensions
	run1=run1+10 -- score updating 
	end
	
	xEnemy2=xEnemy2-250*dt
	if xEnemy2 < -128 then
	xEnemy2 = 1000 -- spacing between the 2 enemies w resetting lamma y3addi el max dimensions
	run2=run2+20 -- score updating
	end
	
	xEnemy3=xEnemy3-375*dt
	if xEnemy3 < -128 then
	xEnemy3 = 1200 -- spacing between the 2 enemies w resetting lamma y3addi el max dimensions
	run3=run3+30 -- score updating
	end
	score=run1+run2+run3
--Physics el juming
	if player.velocity ~= 0 then 
        player.y = player.y + player.velocity * dt
        player.velocity = player.velocity - gravity * dt
        if player.y > 585 then --elground level
            player.velocity = 0
            player.y = 585
        end
    end

	--collision
	if ((player.x-xEnemy1>1) and (player.y>=465)) and (player.x-xEnemy1<185) then
	dead=not dead
	end
	if ((player.x-xEnemy2>1) and (player.y>=465)) and (player.x-xEnemy2<185) then
	dead=not dead
	end
	if ((player.x-xEnemy3>1) and (player.y>=465)) and (player.x-xEnemy3<185) then
	dead=not dead
	end
	--El controls
    if love.keyboard.isDown("up") then
        if player.velocity == 0 then 
            player.velocity = jump-- soot el jump
			love.audio.play(jumpSound)

        end
    end
	 if love.keyboard.isDown("right") then
        player.x=player.x + 500*dt
    end
	if love.keyboard.isDown("left") then
        player.x=player.x - 500*dt
	end
	
	end
	
	if dead==true then
	if (player.y >0) then
	player.y=player.y-500*dt
	music:stop()
	end
	if (player.y<0) then

	end
	end
end
end
function love.keypressed(key)
if key == " " then
      start=true
   end
   if key == "escape" then
      love.event.quit()
   end
	if dead==true then
	   if key == "r" then
	love.load() 
	end
	if key == "R" then
	love.load() 
	end
	end

end
