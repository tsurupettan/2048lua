

function love.load()

	-- Set window size
	tileSize = 128;
	love.window.setMode(tileSize * 4, tileSize * 4, 
						{resizable=false, vsync=false } )

	-- get Window Dimension
	winWidth, winHeight = love.graphics.getDimensions( )
	love.graphics.setColor(255,255,255)

	-- Initialize grid
	grid = {}
	for row = 0, 5 do
		grid[row] = {}
	end
	grid[math.random(4)][math.random(4)] = 2
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

function combineCell( grid, row1, col1, row2, col2, toRow, toCol )
	sumVal = grid[row1][col1] + grid[row2][col2]
	grid[row1][col1] = nil
	grid[row2][col2] = nil
	grid[toRow][toCol] = sumVal
end

function moveCell( grid, fromRow, fromCol, toRow, toCol )
	fromVal = grid[fromRow][fromCol]
	grid[fromRow][fromCol] = nil
	grid[toRow][toCol] = fromVal
end

function love.keypressed( key, isrepeat)
	if key == 'left' then
		for row = 1, 4 do
			prevNilCol = 1
			prevNumCol = 0
			for col = 1, 4 do
				currCell = grid[row][col]
				if currCell ~= nil then
					if grid[row][prevNumCol] == currCell then
						combineCell(grid, row, prevNumCol, row, col, row, prevNilCol - 1)
						prevNumCol = prevNilCol
					else
						moveCell(grid, row, col, row, prevNilCol)
						prevNumCol = prevNilCol
						prevNilCol = prevNilCol + 1
					end					
				end
			end
		end
	end
	if key == 'right' then
		for row = 1, 4 do
			prevNilCol = 4
			prevNumCol = 5
			for col = 4, 1, -1 do
				currCell = grid[row][col]
				if currCell ~= nil then
					if grid[row][prevNumCol] == currCell then
						combineCell(grid, row, prevNumCol, row, col, row, prevNilCol + 1)
						prevNumCol = prevNilCol
					else
						moveCell(grid, row, col, row, prevNilCol)
						prevNumCol = prevNilCol
						prevNilCol = prevNilCol - 1
					end					
				end
			end
		end
	end
	if key == 'up' then
		for col = 1, 4 do
			prevNilRow = 1
			prevNumRow = 0
			for row = 1, 4 do
				currCell = grid[row][col]
				if currCell ~= nil then
					if grid[prevNumRow][col] == currCell then
						combineCell(grid, prevNumRow, col, row, col, prevNilRow - 1, col)
						prevNumRow = prevNilRow
					else
						moveCell(grid, row, col, prevNilRow, col)
						prevNumRow = prevNilRow
						prevNilRow = prevNilRow + 1
					end					
				end
			end
		end
	end
	if key == 'down' then
		for col = 1, 4 do
			prevNilRow = 4
			prevNumRow = 5
			for row = 4, 1, -1 do
				currCell = grid[row][col]
				if currCell ~= nil then
					if grid[prevNumRow][col] == currCell then
						combineCell(grid, prevNumRow, col, row, col, prevNilRow + 1, col)
						prevNumRow = prevNilRow
					else
						moveCell(grid, row, col, prevNilRow, col)
						prevNumRow = prevNilRow
						prevNilRow = prevNilRow - 1
					end					
				end
			end
		end
	end

	emptyCoords = {}
	for row = 1,4 do
		for col = 1,4 do
			if grid[row][col] == nil then
				table.insert(emptyCoords, { row, col })
			end
		end
	end
	randomCoord = emptyCoords[ math.random( table.getn(emptyCoords) ) ]
	grid[randomCoord[1]][randomCoord[2]] = math.random(2) * 2
end

function love.keyreleased( key, isrepeat)
end
