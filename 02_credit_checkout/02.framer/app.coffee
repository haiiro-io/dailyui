Framer.Device.background.backgroundColor = "#D6EDFF"

{TextLayer, convertTextLayers} = require 'TextLayer'
sketch = Framer.Importer.load("imported/UI%2302@1x", scale: 1)

flow = new FlowComponent
flow.showNext(sketch.payment)

sketch.cardC.opacity = 0
sketch.cardC.scale = 0

scroll = ScrollComponent.wrap(sketch.cards)

scroll.scrollHorizontal = true
scroll.scrollVertical = false

sketch.scrollNav1.opacity = 1
sketch.scrollNav2.opacity = 0.2
sketch.scrollNav3.opacity = 0.2

scroll.onMove ->
	if scroll.scrollX > 190 and scroll.scrollX < 450
		sketch.scrollNav1.opacity = 0.2
		sketch.scrollNav2.opacity = 1
		sketch.scrollNav3.opacity = 0.2
	else if scroll.scrollX >= 450
		sketch.scrollNav1.opacity = 0.2
		sketch.scrollNav2.opacity = 0.2
		sketch.scrollNav3.opacity = 1
	else
		sketch.scrollNav1.opacity = 1
		sketch.scrollNav2.opacity = 0.2
		sketch.scrollNav3.opacity = 0.2

textAreas = ["cardnumberText", "cardholderText", "expiryMText", "expiryYText", "CVCText", "zipText"]
textLayers = []

for text, i in textAreas
	textLayers[text] = sketch[text].convertToTextLayer()
	textLayers[text].text = ""
	textLayers[text].color = "#5D5D5D"
	textLayers[text].fontSize = 50
	textLayers[text].autoSize = true

type = (text, target, cb) ->
	setTimeout ->
		if (text.length > 0)
			target.text += text.shift()
			type(text, target, cb)
		else
			cb("done");
	, 60

typeAsync = (text, target) ->
	splittedText = text.split("")
	return new Promise (resolve, reject) ->
		type(splittedText, target, resolve)

sketch.cardNew.onTap ->
	flow.showOverlayBottom(sketch.add)

	typeAsync("4242 4242 4242 4242", textLayers.cardnumberText).then () ->
		typeAsync("NAMIKA HAMASAKI", textLayers.cardholderText).then () ->
			typeAsync("12", textLayers.expiryMText).then () ->
				typeAsync("17", textLayers.expiryYText).then () ->
					typeAsync("***", textLayers.CVCText).then () ->
						typeAsync("12345", textLayers.zipText)

	sketch.btnClose.onTap ->
		flow.showPrevious()

	sketch.btnAdd.onTap ->
		flow.showPrevious()
		sketch.cardNew.opacity = 0
		sketch.cardC.opacity = 1
		sketch.cardC.animate
			scale: 1
			options:
				#curve: Bezier.ease
				curve: Spring(damping: 0.5)
				delay: 0
				time: 1
