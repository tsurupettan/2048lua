

function love.load()

	-- Set window size
	tileSize = 128;
	love.window.setMode(tileSize * 4, tileSize * 4, 
						{resizable=false, vsync=false } )

	-- get Window Dimension
	winWidth, winHeight = love.graphics.getDimensions( )
	love.graphics.setColor(255,255,255)



	grid = {}

	count = 2
	for row = 0, 5 do
		grid[row] = {}
		for col = 1, 4 do
			grid[row][col] = count
			-- count = count + 1
		end
	end
	-- grid[1][4] = 0
	-- grid[4][1] = 5
	-- grid[4][4] = 9

end

function love.update(dt)
end

function love.draw()
	-- draw cells
	for row = 1, 4 do
		for col = 1, 4 do 
			currCell = grid[row][col]
			if currCell ~= nil then
				love.graphics.print(currCell, (col - 1) * tileSize, (row - 1) * tileSize, 0, 8, 8 )
			end
		end
	end

	-- Draw gridline
	for loc_x = 0, winWidth, tileSize do
		love.graphics.line(loc_x, 0, loc_x, winHeight)
	end
	for loc_y = 0, winHeight, tileSize do
		love.graphics.line(0 ,loc_y, winWidth, loc_y)
	end
end

function love.keypressed( key, isrepeat)
	if key == 'left' then
		for row = 1, 4 do
			for col = 1, 4 do 
				currCell = grid[row][col]
				nextCell = grid[row][col+1]
				if currCell ~= nil and currCell == nextCell then
					grid[row][col] = nil
					grid[row][col+1] = nil
					for colNew = 1, 4 do
						if grid[row][colNew] == nil then
							grid[row][colNew] = currCell * 2
							break
						end
					end
				end
			end
		end
	end
	if key == 'right' then
		for row = 1, 4 do
			for col = 4, 1,-1 do 
				currCell = grid[row][col]
				nextCell = grid[row][col-1]
				if currCell ~= nil and currCell == nextCell then
					grid[row][col] = nil
					grid[row][col-1] = nil
					for colNew = 4, 1,-1 do
						if grid[row][colNew] == nil then
							grid[row][colNew] = currCell * 2
							break
						end
					end
				end
			end
		end
	end
	if key == 'up' then
		for col = 1, 4 do 
			for row = 1, 4 do
				currCell = grid[row][col]
				nextCell = grid[row+1][col]
				if currCell ~= nil and currCell == nextCell then
					grid[row][col] = nil
					grid[row+1][col] = nil
					for rowNew = 1, 4 do
						if grid[rowNew][col] == nil then
							grid[rowNew][col] = currCell * 2
							break
						end
					end
				end
			end
		end
	end
	if key == 'down' then
		for col = 1, 4 do 
			for row = 4, 1, -1 do
				currCell = grid[row][col]
				nextCell = grid[row-1][col]
				if currCell ~= nil and currCell == nextCell then
					grid[row][col] = nil
					grid[row-1][col] = nil
					for rowNew = 4, 1, -1 do
						if grid[rowNew][col] == nil then
							grid[rowNew][col] = currCell * 2
							break
						end
					end
				end
			end
		end
	end	
end

function love.keyreleased( key, isrepeat)
end
