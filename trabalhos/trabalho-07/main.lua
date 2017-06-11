function love.load ()
    p2 = { x=350, y=550, w=100, h=10 }
	p3 = { x=400, y=250, w=10, h=10, vy=-190,vx = 1}
	bonus = {}
	--[[ trabalho-07
		Array: bonus
		Escopo: O array b é uma variável global
		Tempo de vida: Desde a alocação (val multiplo de 7) até a colisão com a barra ou até perder visão de tela.
		Alocação: É alocado quando a variável val é múltiplo de 7. toda vez que ele aloca a posição x do quadrado é randomica.
		Desalocação: Desaloca quando ocorre uma colisão ou foge da visão da tela.
	--]]

	isPressed = 'F'
	val = 0
	start = 0
	stop=0

end

function love.keypressed (key)
    if key == 'left' then
        if isBorderLeftT(p2) then
			p2[1] = p2[1] - 5
		end	
    elseif key == 'right' then
        if isBorderRightT(p2) then
			p2[1] = p2[1] + 5
		end	
	elseif key == 'space' then
        if isPressed == 'F' then
			isPressed = 'T'
			bonus = 'F' -- condição para alocação no love.update / faz a alocação no start
	end	
    elseif key == 'a' and isPressed == 'F' then
		love.load()
	end
end

function add () -- função de alocação
	for i=1, 3 do
		b[i]={}
		for j=1,14 do
			b[i][j] = { x=j*50, y=(i+l)*30, w=30, h=10}
		end
	end
end 

function collidesBonus () -- função de desalocação após colisão durante tempo de bonus
	for i=1, 3 do
		for j=1, 14 do
			if b[i][j].x ~= nil then
				if collides(b[i][j], p3) then
					if	collidesX(b[i][j],p3) then
						p3.vy=p3.vy*(-1.01)
					elseif collidesY(b[i][j],p3) then
						p3.vx=p3.vx*(-1)
						p3.vy=p3.vy*(1.01)
					end
					b[i][j].x=nil
					b[i][j].y=nil
					b[i][j].w=nil
					b[i][j].h=nil
					val=val+1
				end
			end
		end 
	end
end

function desaloc() -- função de desalocação após término de cada tempo de bonus
	for i=1, 3 do
		for j=1, 14 do
			b[i][j].x=nil
			b[i][j].y=nil
			b[i][j].w=nil
			b[i][j].h=nil
		end
	end
end		

function isBorderDown(o)
	return (o.y>=610)
end
function isBorderLeft(o)
	return (o.x>=5)
end

function isBorderRight(o)
	return (o.x+o.w<=800)
end
function isBorderLeftT(o)
	return (o[1]>=5)
end

function isBorderRightT(o)
	return (o[1]+o[3]<=800)
end
function isBorderTop(o)
	return (o.y>=0)
end

function collides (o1, o2)
    return (o1.x+o1.w >= o2.x) and (o1.x <= o2.x+o2.w) and
           (o1.y+o1.h >= o2.y) and (o1.y <= o2.y+o2.h)
end

function collidesX (o1, o2)
    return (o1.x+o1.w >= o2.x) and (o1.x <= o2.x+o2.w) 
end

function collidesY (o1, o2)
    return (o1.y+o1.h >= o2.y) and (o1.y <= o2.y+o2.h)
end

function collidesT (o1, o2)
    return (o1[1]+o1[3] >= o2.x) and (o1[1] <= o2.x+o2.w) and
           (o1[2]+o1[4] >= o2.y) and (o1[2] <= o2.y+o2.h)
end

function collidesXT (o1, o2)
    return (o1[1]+o1[3] >= o2.x) and (o1[1] <= o2.x+o2.w) 
end

function collidesYT (o1, o2)
    return (o1[2]+o1[4] >= o2.y) and (o1[2] <= o2.y+o2.h)
end	

function love.update (dt)
	if (val%5==0) and (val>0) then
		bonus='T'
		start=love.timer.getTime()
	end
	
	if (bonus=='F') then 
		add() -- faz alocação sempre que não estiver no tempo de bônus, ou seja, no inicio do jogo e ao final de cada tempo de bônus
	end
	
    if isPressed=='T' then
		p3.y = p3.y - p3.vy*dt
		p3.x = p3.x + p3.vx*dt
		if isBorderLeft(p3)==false or isBorderRight(p3)==false  then
			p3.vx=p3.vx*(-1)
		end	
		if isBorderTop(p3)==false then
			p3.vy=p3.vy*(-1)
		end
	end

	if love.keyboard.isDown("left") then
		if isBorderLeftT(p2) then
			if love.keyboard.isDown("lshift") then
				p2[1] = p2[1] - 20
			else
				p2[1] = p2[1] - 5
			end
		end	
    end
	if love.keyboard.isDown("right") then
        if isBorderRightT(p2) then
			if love.keyboard.isDown("lshift") then
				p2[1] = p2[1] + 20
			else
				p2[1] = p2[1] + 5
			end
		end
    end

    if collidesT(p2, p3) then
		if collidesXT(p2,p3) then
			p3.vx=(10*(p3.x-((p2[3]/2)+p2[1])))
			if ((p2[1]+(p2[3]/2)<p3.x+p3.w) and p3.vx<0) or ((p2[1]+(p2[3]/2)>p3.x+p3.w) and p3.vx>0) then
				p3.vx=(-1)*p3.vx
			end
		elseif	collidesYT(p2,p3) then
			p3.vx=p3.vx*(-1)
		end
		p3.vy=p3.vy*(-1.01)

    end
	
	for i=1, 3 do
		for j=1, 14 do
			if collides(a[i][j], p3) then
				if	collidesX(a[i][j],p3) then
					p3.vy=p3.vy*(-1.01)
				elseif collidesY(a[i][j],p3) then
					p3.vx=p3.vx*(-1)
					p3.vy=p3.vy*(1.01)
				end
				a[i][j].x=0
				a[i][j].y=0
				a[i][j].w=0
				a[i][j].h=0
				val=val+1
			end
		end 
	end

end

function love.draw ()
    love.graphics.setBackgroundColor( 0, 150, 0, 255 )
    love.graphics.setColor(0,0 , 0, 255)
	love.graphics.rectangle('fill', p2[1],p2[2], p2[3],p2[4])
    love.graphics.rectangle('fill', p3.x,p3.y, p3.w,p3.h)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("BONUS: Pressione S a cada 5 pontos", 480, 570, 0, 1.2, 1.2)
    love.graphics.print("Pontuacao: "..val, 40, 570, 0, 1.2, 1.2)
	love.graphics.print("Quadrados Restantes: ".. 84-val, 220, 570, 0, 1.2, 1.2)

	for i=1, 3 do
		for j=1, 14 do
			love.graphics.rectangle('fill', a[i][j].x,a[i][j].y, a[i][j].w,a[i][j].h)
		end
	end
	
	if love.keyboard.isDown("s") and bonus=='T' then
		love.graphics.print("3 SEGUNDOS DE BONUS", 330, 300, 0, 1.2, 1.2)
		love.graphics.print("Mantenha a tecla S pressionada", 290, 320, 0, 1.2, 1.2)
		for i=1, 3 do
			for j=1, 14 do
				if b[i][j].x ~= nil then
					love.graphics.rectangle('fill', b[i][j].x,b[i][j].y, b[i][j].w,b[i][j].h)
				end
			end
		end
		collidesBonus() -- faz a desalocação de cada item colidido durante o tempo de bonus	
		stop=love.timer.getTime()
		if (stop-start>=3) then -- timer bonus
			bonus='F'
			desaloc() -- desaloca todos os itens após término de cada tempo de bônus
		end
	end
	
	if isBorderDown(p3) then
		isPressed = 'F'
		bonus = 'F'
		love.graphics.print("Pontuacao: "..val, 325, 250, 0, 1.2, 1.2)
		love.graphics.print("GAME OVER!", 330, 300, 0, 1.2, 1.2)
		love.graphics.print("Pressione a letra A para recomecar", 250, 320, 0, 1.2, 1.2)
	end
		if val == 84 then
		isPressed = 'F'
		bonus = 'F'
		love.graphics.print("Parabens, voce ganhou !!!! Pressione a letra A para recomecar", 150, 320, 0, 1.2, 1.2)
end

end

	
	
	
	quadrados=84
	a = {}
    for i=1, 6 do
		a[i]={}
		for j=1,14 do
           a[i][j] = { x=j*50, y=i*30, w=30, h=10}
		end
    end
	
	isPressed=0
	val = 0
	hit=0
	exist=0;

end

function love.keypressed (key)
    if key == 'left' then
        if isBorderLeft(p2) then
			p2.x = p2.x - 5
		end	
    elseif key == 'right' then
        if isBorderRight(p2) then
			p2.x = p2.x + 5
		end	
	elseif key == 'space' then
        if isPressed==0 then
			isPressed=1
	end	
    elseif key == 'a' and isPressed==0 then
		love.load()
	end
end
function isBorderDown(o)
	return (o.y>=610)
end
function isBorderLeft(o)
	return (o.x>=5)
end

function isBorderRight(o)
	return (o.x+o.w<=800)
end

function isBorderTop(o)
	return (o.y>=0)
end

function collides (o1, o2)
    return (o1.x+o1.w >= o2.x) and (o1.x <= o2.x+o2.w) and
           (o1.y+o1.h >= o2.y) and (o1.y <= o2.y+o2.h)
end

function collidesX (o1, o2)
    return (o1.x+o1.w >= o2.x) and (o1.x <= o2.x+o2.w) 
end

function collidesY (o1, o2)
    return (o1.y+o1.h >= o2.y) and (o1.y <= o2.y+o2.h)
end

function erase() --desaloca valores após o bloco de bonus alcançar a borda inferior ou ser acertado pela barra
	bonus.x=nil
	bonus.y=nil
	bonus.w=nil
	bonus.h=nil
	bonus.vy=nil

end

function alloc(x,y,w,h,vy) --aloca em novo bonus
	bonus.x=x
	bonus.y=y
	bonus.w=w
	bonus.h=h
	bonus.vy=h

end;

function love.update (dt)
    if isPressed==1 then
		p3.y = p3.y - p3.vy*dt
		p3.x = p3.x + p3.vx*dt
		if isBorderLeft(p3)==false or isBorderRight(p3)==false  then
			p3.vx=p3.vx*(-1)
		end	
		if isBorderTop(p3)==false then
			p3.vy=p3.vy*(-1)
		end
	end
	
	--função que verifica colisão do objeto a ser removido
	if exist==1 then
		bonus.y = bonus.y + bonus.vy*0.2;
		if collides(p2,bonus) then
			exist=0
			hit=0
			val=val+50
			erase()
		end
	end
	
	--função que verifica colisão do objeto a ser removido
	if exist ==1 then
		if isBorderDown(bonus) then
			exist=0
			hit=0
			erase()
		end
	end
	
	
	
	if love.keyboard.isDown("left") then
		if isBorderLeft(p2) then
			if love.keyboard.isDown("lshift") then
				p2.x = p2.x - 20
			else
				p2.x = p2.x - 5
			end
		end	
    end
	if love.keyboard.isDown("right") then
        if isBorderRight(p2) then
			if love.keyboard.isDown("lshift") then
				p2.x = p2.x + 20
			else
				p2.x = p2.x + 5
			end
		end
    end
	
    if collides(p2, p3) then
		if collidesX(p2,p3) then
			p3.vx=(10*(p3.x-((p2.w/2)+p2.x)))
			if ((p2.x+(p2.w/2)<p3.x+p3.w) and p3.vx<0) or ((p2.x+(p2.w/2)>p3.x+p3.w) and p3.vx>0) then
				p3.vx=(-1)*p3.vx
			end
		elseif	collidesY(p2,p3) then
			p3.vx=p3.vx*(-1)
		end
		p3.vy=p3.vy*(-1.01)
	
    end
	
	for i=1, 6 do
		for j=1, 14 do
			if collides(a[i][j], p3) then
				if	collidesX(a[i][j],p3) then
					p3.vy=p3.vy*(-1.01)
				elseif collidesY(a[i][j],p3) then
					p3.vx=p3.vx*(-1)
					p3.vy=p3.vy*(1.01)
				end
				a[i][j].x=0
				a[i][j].y=0
				a[i][j].w=0
				a[i][j].h=0
				val=val+1
				quadrados=quadrados-1
				--condição do objeto existir
				if val % 7 ==0 and exist==0 then
					hit=1
					alloc(math.random(0,600),300,15,15,10)
				end
			end
		end
	end

end

function love.draw ()
    love.graphics.setBackgroundColor( 0, 120, 0, 255 )
    love.graphics.setColor(0,0 , 0, 255)
	love.graphics.rectangle('fill', p2.x,p2.y, p2.w,p2.h)
    love.graphics.rectangle('fill', p3.x,p3.y, p3.w,p3.h)
	love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("Pontuacao: ".. val, 50, 570, 0, 1.2, 1.2)
	love.graphics.print("Quadrados Restantes: ".. quadrados, 250, 570, 0, 1.2, 1.2)
	love.graphics.print("Velocidade: ".. math.floor(p3.vy), 500, 570, 0, 1.2, 1.2)

	for i=1, 6 do
		for j=1, 14 do
			love.graphics.rectangle('fill', a[i][j].x,a[i][j].y, a[i][j].w,a[i][j].h)
		end
	end
	
	if hit==1 then
		exist=1
		love.graphics.setColor(255, 255, 0, 255)
		love.graphics.rectangle('fill', bonus.x,bonus.y, bonus.w,bonus.h)
		love.graphics.print("PEGUE O QUADRADO DE BONUS: ",250, 5, 0, 1.2, 1.2)

	end

	if isBorderDown(p3) then
		isPressed=0
		love.graphics.print("Pontuacao: "..val, 325, 250, 0, 1.2, 1.2)
		love.graphics.print("GAME OVER!", 330, 300, 0, 1.2, 1.2)
		love.graphics.print("Pressione a letra A para recomecar", 250, 320, 0, 1.2, 1.2)
	end
		if quadrados==0 then
		isPressed=0
		love.graphics.print("Parabens, voce ganhou !!!! Pressione a letra A para recomecar", 150, 320, 0, 1.2, 1.2)
	end

end
