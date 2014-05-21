
function love.load()

	-- Set window sizen
	tile_size = 128;
	love.window.setMode(tile_size * 4, tile_size * 4, 
						{resizable=false, vsync=false } )

	-- get Window Dimension
	win_width, win_height = love.graphics.getDimensions( )

end

function love.update(dt)
end

function love.draw()
end

function love.keypressed( key, isrepeat)
end

function love.keyreleased( key, isrepeat)
end
