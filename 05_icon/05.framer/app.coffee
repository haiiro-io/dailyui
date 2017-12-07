Framer.Device.background.backgroundColor = "#1D67FF"
sketch = Framer.Importer.load("imported/05@1x", scale: 1)

sketch.canvas.x = Align.center
sketch.canvas.y = Align.center
sketch.innerrect.opacity = 0
sketch.goal.opacity = 0
sketch.innerrect.y = -500
sketch.goal.y = -500

rect = new Layer
	x: Align.center
	y: Align.center
	width: 100
	height: 100
	borderRadius: 10
	backgroundColor: "white"
	shadow1:
		color: "#1344A9"
		y: 4
		blur: 6
	parent: sketch.canvas
	index: -1

###
01. Setup first tap
###

ballx = sketch.ball.x + 2
bally = sketch.ball.y + 2
rectx = rect.x + 2
recty = rect.y + 2
t = 0.1

ballTapAnime = new Animation sketch.ball,
	x: ballx
	y: bally
	options:
		time: t
		
rectTapAnime = new Animation rect,
	x: rectx
	y: recty
	options:
		time: t

ballTapAnime_B = ballTapAnime.reverse()
rectTapAnime_B = rectTapAnime.reverse()
ballTapAnime.on Events.AnimationEnd, ballTapAnime_B.start
rectTapAnime.on Events.AnimationEnd, rectTapAnime_B.start

###
02. Setup ball up animation
###

ballUp = new Animation sketch.ball,
	y: -1000
	options:
		curve: Bezier.easeOut
		time: 0.3
		
rectScaleUp = new Animation rect,
	width: 150
	x: 125
	y: 74
	options:
		curve: Bezier.ease
		time: 0.5
		delay: 0.4

###
03. Setup ball down animation
###

innerShow = new Animation sketch.innerrect,
	y: 96
	options:
		curve: Bezier.easeOut
		time: 0.8
goalShow = new Animation sketch.goal,
	y: 140
	options:
		curve: Bezier.easeOut
		time: 0.8
ballDown = new Animation sketch.ball,
	y: 1000
	options:
		curve: Spring (damping: 0.5)
		time: 4
		
###
04. Setup reset animation
###

removeInnerrect = new Animation sketch.innerrect,
	opacity: 0
	scale: 0
	y: 100
	options:
		curve: Bezier.easeOut
		time: 0.3

removeGoal = new Animation sketch.goal,
	opacity: 0
	scale: 0
	y: 100
	options:
		curve: Bezier.easeOut
		time: 0.3

resetRect = new Animation rect,
	width: 100
	x: 150
	y: 100
	options:
		delay: 1

resetBall = new Animation sketch.ball,
	y: 115
	options:
		curve: Spring (damping: 0.5)
		time: 1
		delay: 1.2

###
Start Animation
###

setTimeout ->
	ballTapAnime.start()
	rectTapAnime.start()
, 2000

rectTapAnime_B.on Events.AnimationEnd, ->
	ballUp.start()
	rectScaleUp.start()

rectScaleUp.onAnimationStop ->
	sketch.innerrect.opacity = 1
	sketch.goal.opacity = 1
	
	innerShow.start()
	goalShow.start()
	
	setTimeout ->
		ballDown.start()
	, 1000
	
	setTimeout ->
		removeInnerrect.start()
		removeGoal.start()
		resetRect.start()
		
		sketch.ball.y = -1000
		resetBall.start()
	, 2000