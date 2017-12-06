Framer.Device.background.backgroundColor = "#F3F3ED"
sketch = Framer.Importer.load("imported/UI%2304@1x", scale: 1)

Utils.globalLayers(sketch)

prefield = new Layer
	parent: cal
	width: 335
	height: 50
	x: 20
	y: 226
	backgroundColor: "#ffffff"
	opacity: 0
prefieldtext.parent = prefield
prefieldtext.x = 0
prefieldtext.y = 0

numfield.parent = cal
numfield.x = 55
numfield.y = 226

sign.parent = cal
sign.x = 20
sign.y = 226
sign.scale = 3
sign.opacity = 0
sign.text = "　"

tapAnimation = (layer) ->
	animationA = new Animation layer,
		brightness: 125
		options:
			curve: Bezier.easeIn
			time: 0.3
			delay: 0
	animationB = animationA.reverse()
	animationA.on Events.AnimationEnd, animationB.start
	animationA.start()

memoizedNum = 0	
lastInput = ""

for layer, index in sketch.numbers.subLayers
	layer.on Events.Tap, (event, layer) ->
		next = layer.name[1]
		next = "." if layer.name == "dot"

		if numfield.text == "0"
			numfield.text = next
		else
			if lastInput == "+"
				numfield.text = next
				prefieldtext.text = memoizedNum.toString()
				prefieldtext.fontSize = 30
				prefield.animate
					x: 20
					y: 176
					opacity: 1
					options:
						curve: Bezier.easeOut
						time: 0.5
			else
				numfield.text += next
		
		lastInput = next	
		tapAnimation(layer)
		
equal.onTap ->
	tapAnimation(equal)

plus.onTap ->
	tapAnimation(plus)
	sign.text = "+"
	lastInput = "+"
	memoizedNum = parseInt(numfield.text)
	sign.animate
		opacity: 1
		scale: 1
		options:
			curve: Bezier.easeIn
			time: 0.3

equal.onTap ->
	numfield.text = (memoizedNum + parseInt(numfield.text)).toString()
	#sign.text = "　"
	sign.animate
		opacity: 0
		scale: 3
		options:
			curve: Bezier.easeIn
			time: 0.3
	prefield.animate
		opacity: 0
		y: 226
		options:
			curve: Bezier.easeIn
			time: 0.3