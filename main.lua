

function love.load()

	-- Set window sizen
	tileSize = 128;
	love.window.setMode(tileSize * 4, tileSize * 4, 
						{resizable=false, vsync=false } )

	-- get Window Dimension
	winWidth, winHeight = love.graphics.getDimensions( )
	love.graphics.setColor(255,255,255)



	grid = {}

	count = 2
	for row = 1, 4 do
		table.insert(grid, {})
		for col = 1, 4 do
			table.insert(grid[row], count)
			-- count = count + 1
		end
	end
end

function love.update(dt)
end

function love.draw()
	-- draw cells
	for row, currRow in ipairs(grid) do
		for col, currCell in ipairs(currRow) do
			if currCell ~= nil then
				love.graphics.print(currCell, (row - 1) * tileSize, (col - 1) * tileSize, 0, 8, 8 )
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
end

function love.keyreleased( key, isrepeat)
end
