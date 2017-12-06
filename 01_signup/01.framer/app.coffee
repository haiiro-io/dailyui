Framer.Device.background.backgroundColor = "#E5DDC8"

flow = new FlowComponent
flow.showNext(first)

loading.opacity = 0

textEmail.text = ""
textPassword.text = ""

unko = (rest, target, cb) ->
	setTimeout ->
		if (rest.length > 0)
			target.text += rest.shift()
			unko(rest, target, cb)
		else
			cb();
	, 60

setTimeout ->
	unko("user@example.com".split(""), textEmail, () ->
		# after email input
		underlineEmail.style.background = "#ccc"
		underlinePassword.style.background = "#FF9772"
		unko("*********".split(""), textPassword, () ->
			# after password input
			)
	)
, 2000

btnCreate.onTap ->
	btnCreateText.opacity = 0
	btnCreate.animate
		width: 60
		options: 
			curve: Bezier.ease
			time: 0.4
	
	form.animate
		width: 0
		height: 0
		opacity: 0
		options:
			curve: Bezier.easeIn
			time: 0.2
			delay: 0

	loading.animate
		opacity: 1
		options: 
			curve: Bezier.easeOut
			time: 0.3
			delay: 0

	loadingAnimationA = new Animation loading,
		rotation: 360
		options:
			curve: Bezier.linear
			repeat: 3
			time: 0.8
			delay: 0
	loadingAnimationA.start()