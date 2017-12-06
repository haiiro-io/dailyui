Framer.Device.background.backgroundColor = "#588D67"

targetWidth = 800
targetHeight = 600

###
horizontalPositionForTarget = ->
	(Framer.Device.screen.width - targetWidth) / 2

verticalPositionForTarget = ->
	(Framer.Device.screen.height - targetHeight) / 2	
###

containerBg = new Layer
	x: Align.center
	y: Align.center
	width: targetWidth
	height: targetHeight
	backgroundColor: '#fff'
	shadowY: 4
	shadowBlur: 15
	shadowColor: 'rgba(0,0,0,0.5)'
	borderRadius: 10

scroll = new ScrollComponent
	width: 800
	height: 600
	x: Align.center
	y: Align.center
	borderRadius: 10

#scroll.clip = true
web.parent = scroll.content
scroll.scrollHorizontal = false
scroll.scrollVertical = true
scroll.mouseWheelEnabled = true

btn.onTap ->
	scrollTo = () ->
		setTimeout ->
			scroll.scrollY += 7
			copy.y = Utils.modulate(scroll.scrollY, [0, 500], [1235, 727], true)
			photo.y = Utils.modulate(scroll.scrollY, [0, 500], [980, 680], true)
			copy2.y = Utils.modulate(scroll.scrollY, [200, 800], [1830, 1210], true)
			photo2.y = Utils.modulate(scroll.scrollY, [200, 800], [1450, 1150], true)
			copy3.y = Utils.modulate(scroll.scrollY, [800, 1200], [2272, 1652], true)
			photo3.y = Utils.modulate(scroll.scrollY, [800, 1200], [1900, 1600], true)
			if scroll.scrollY < 1388
				scrollTo()
		, 25
	scrollTo()

scroll.onMove ->
	copy.y = Utils.modulate(scroll.scrollY, [0, 500], [1235, 727], true)
	photo.y = Utils.modulate(scroll.scrollY, [0, 500], [980, 680], true)
	copy2.y = Utils.modulate(scroll.scrollY, [200, 800], [1830, 1210], true)
	photo2.y = Utils.modulate(scroll.scrollY, [200, 800], [1450, 1150], true)
	copy3.y = Utils.modulate(scroll.scrollY, [800, 1200], [2272, 1652], true)
	photo3.y = Utils.modulate(scroll.scrollY, [800, 1200], [1900, 1600], true)

window.onresize = ->
	#container.x = horizontalPositionForTarget
	#container.y = verticalPositionForTarget
	containerBg.x = Align.center
	containerBg.y = Align.center
	scroll.x = Align.center
	scroll.y = Align.center