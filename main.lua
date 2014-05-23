IH = require 'imagehelper'

function love.load()

	-- Set window size
	tileSize = 128;
	love.window.setMode(tileSize * 4, tileSize * 4, 
						{resizable=false, vsync=false } )

	-- get Window Dimension
	winWidth, winHeight = love.graphics.getDimensions( )
	love.graphics.setColor(255,255,255)

	-- set background
	imgFiles = {
				'cell_img/2.png',
				'cell_img/4.png',
				'cell_img/8.png',
				'cell_img/16.png',
				'cell_img/32.png',
				'cell_img/64.png',
				'cell_img/128.png',
				'cell_img/256.png',
				'cell_img/512.png',
				'cell_img/1024.png',
				'cell_img/2048.png',
				'cell_img/empty.png',
				 }
	canvasList = {}
	for i, imgFile in ipairs(imgFiles) do
		table.insert(canvasList, IH.createImageCanvas_Fit(imgFile,tileSize,tileSize))
	end

	-- Initialize grid
	grid = {}
	for row = 0, 5 do
		grid[row] = {}
	end

	grid[math.random(4)][math.random(4)] = 1
end

function love.update(dt)
end

function love.draw()
	-- draw cells
	for row = 1, 4 do
		for col = 1, 4 do 
			currCell = grid[row][col]
			if currCell ~= nil then
				love.graphics.draw(canvasList[currCell], 
								   (col - 1) * tileSize, 
								   (row - 1) * tileSize )
			else
				love.graphics.draw(canvasList[table.getn(canvasList)], 
								   (col - 1) * tileSize, 
								   (row - 1) * tileSize )
			end
		end
	end

	-- Draw gridline
	love.graphics.setLineWidth( 9 )
	for loc_x = 0, winWidth, tileSize do
		love.graphics.line(loc_x, 0, loc_x, winHeight)
	end
	for loc_y = 0, winHeight, tileSize do
		love.graphics.line(0 ,loc_y, winWidth, loc_y)
	end
end

function combineCell( grid, row1, col1, row2, col2, toRow, toCol )
	sumVal = grid[row1][col1] + 1
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

	-- Collect empty cells
	emptyCoords = {}
	for row = 1,4 do
		for col = 1,4 do
			if grid[row][col] == nil then
				table.insert(emptyCoords, { row, col })
			end
		end
	end

	isGameOver = false
	if table.getn(emptyCoords) == 0 then
		foundPair = false
		for row = 1, 4 do
			for col = 1, 4 do
				if grid[row][col] == grid[row][col+1] or 
				   grid[row][col] == grid[row+1][col]
				then
					foundPair = true
				end
			end
		end
		isGameOver = not foundPair
	else
		-- Add 2 or 4 at random empty cell
		randomCoord = emptyCoords[ math.random( table.getn(emptyCoords) ) ]
		seed = math.random(4)
		if seed == 1 then
			grid[randomCoord[1]][randomCoord[2]] = 2
		else
			grid[randomCoord[1]][randomCoord[2]] = 1
		end
	end
end

function love.keyreleased( key, isrepeat)
end
