# Import file "06"
sketch = Framer.Importer.load("imported/06@1x", scale: 1)
nameSection = sketch.names

nameSection.opacity = 0
showNameSection = new Animation nameSection,
	opacity: 1
	options:
		delay: 1
		time: 0.4
		curve: Bezier.easeIn

menu = sketch.menu
menu.x = - 350
slideMenu = new Animation menu,
	x: 20
	options:
		delay: 1
		time: 0.45

activeTab = sketch.activetab
inactiveTab = sketch.inactive
activeTab.visible = true
activeTab.opacity = 0
hideInactiveTab = new Animation inactiveTab,
	opacity: 0
	options:
		delay: 0.05
		time: 0.3
showActiveTab = new Animation activeTab,
	opacity: 1
	options:
		delay: 0.15
		time: 0.4

photos = [sketch.mainPhoto, sketch.photo1, sketch.photo2, sketch.photo3, sketch.photo4, sketch.photo5, sketch.photo6].reverse()
slidePhotos = []

for photo, index in photos
	original = photo.y
	photo.y = -500
	slidePhotos.push new Animation photo,
		y: original
		options:
			delay: index * 0.1
			time: 0.8
			curve: Bezier(0.25, 0.4, 0.5, 1.1, 1)

showNameSection.on Events.AnimationEnd, slideMenu.start
slideMenu.on Events.AnimationEnd, ->
	hideInactiveTab.start()
	showActiveTab.start()
showActiveTab.on Events.AnimationEnd, ->
	for photoAnimation in slidePhotos
		photoAnimation.start()

showNameSection.start()

followButton = sketch.follow
followingButton = sketch.following
followingButton.visible = true
followingButton.scale = 0

zoomFollowButton = new Animation followButton,
	scale: 0.95
	options:
		time: 0.1

hideFollowButton = new Animation followButton,
	opacity: 0
	options:
		time: 0.5

showFollowingButton = new Animation followingButton,
	scale: 1
	options:
		time: 0.4

followButton.onClick ->
	zoomFollowButton.restart()
	hideFollowButton.start()
	followButton.scale = 0.8
	showFollowingButton.start()