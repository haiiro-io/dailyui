# Import file "07"
sketch = Framer.Importer.load("imported/07@2x", scale: 1)
Utils.globalLayers(sketch)

sliderRate = (layer) ->
	a = Utils.modulate(layer.x,[base1.x-10, base1.width-layer.width/2-10],[0,100],false)
	Math.round(a.toString())

knob1.draggable.enable = true
knob1.draggable.horizontal = true
knob1.draggable.vertical = false
knob1.draggable.overdrag = false
knob1.draggable.bounce = false
knob1.draggable.momentum = false
knob1.draggable.constraints =
	x: base1.x - 10
	y: base1.y
	width: base1.width + knob1.width/2
	height: base1.height

percent.parent = brightness
percent.x = 220
percent.text = sliderRate(knob1) + "%"

base_off.opacity = 0
empty.opacity = 0

toggleSwitch = true

knob.states = 
	on:
		x: 21
	off:
		x: -3
	animationOptions:
		time: 0.3
base_off.states = 
	on:
		opacity: 1
	off:
		opacity: 0
	animationOptions:
		time: 0.3

settingsArray = [timer, colors, brightness]

mask = new Layer
	width: 320
	height: 450
	x: 24
	y: 78
	backgroundColor: "transparent"
	parent: sp
	clip: true
	index: 1
settings.superLayer = mask
settings.x = 0
settings.y = 20

toggle.onTap ->
	knob.stateCycle "off", "on"
	base_off.stateCycle "on", "off"

	switch
		when toggleSwitch == true
			toggleSwitch = false
			settings.opacity = 0
			illust.animate
				brightness: 0
			empty.animate
				opacity: 1
				options:
					time: 0.5
		when toggleSwitch == false
			toggleSwitch = true
			illust.animate
				brightness: sliderRate(knob1)
			empty.opacity = 0
			settings.opacity = 1
			for setting, index in settingsArray
				original = setting.y
				setting.y = -600
				setting.animate
					y: original
					options:
						delay: index * 0.1
						time: 0.7
						curve: Bezier(0.25, 0.4, 0.5, 1.1, 1)

overlay = new Layer
	backgroundColor: "FFFFED"
	width: Screen.width
	height: Screen.height
	parent: illust
overlay.style.mixBlendMode = "multiply"
illust.brightness = sliderRate(knob1)

knob1.onDrag ->
	console.log(knob1.x)
	a = sliderRate(knob1)
	percent.text = a + "%"
	illust.brightness = a

colorSelections = [
	{ color: "FFFFFF", button: color3 },
	{ color: "F8E1FE", button: color5 }
]

colorSelections.forEach (colorSelection) ->
	colorSelection.button.onTap ->
		colorOn.x = colorSelection.button.x - 1
		colorOn.y = colorSelection.button.y - 1
		overlay.animate
			backgroundColor: colorSelection.color
			options:
				time: 0.4