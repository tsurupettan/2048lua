IH = {}

function IH.createImageCanvas_Fit( img_path, width, height )
	image = love.graphics.newImage( img_path )

	canvas = love.graphics.newCanvas( width, height)
	love.graphics.setCanvas(canvas)
		canvas:clear()
		love.graphics.setBlendMode('alpha')
		love.graphics.draw(image, 0, 0, 0,
						   width/image:getWidth(),
						   height/image:getHeight()
						  )
	love.graphics.setCanvas()
	return canvas
end

return IH