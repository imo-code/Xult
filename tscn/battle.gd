extends Node2D

var my_party : Party
var menu_page : MenuPage
var selected_unit : Unit
var enemy : Unit
var active : bool

enum MenuPage {
	MAIN,
	ACTIONS,
	SPELLS
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var sb1 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton1")
	var sb2 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton2")
	var sb3 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton3")
	var sb4 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton4")
	var sb = [sb1,sb2,sb3,sb4]
	
	active = true
	#visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func setParty(playerparty:Party):
	my_party = playerparty

func setEnemy(enemies:Party):
	enemy = enemies.mid

func loadGUI():
	#declaring unit textures
	var psc_left = get_node("BG_ColorRect/Player_ColorRect/PlayerSpriteContainer/LeftPartyTex")
	var psc_mid = get_node("BG_ColorRect/Player_ColorRect/PlayerSpriteContainer/MidPartyTex")
	var psc_right = get_node("BG_ColorRect/Player_ColorRect/PlayerSpriteContainer/RightPartyTex")
	
	#declaring unit stats
	var itex = get_node("BG_ColorRect/Info_ColorRect/InfoTextureRect")
	var ilab = get_node("BG_ColorRect/Info_ColorRect/InfoRichTextLabel")

	var t = ""
	ilab.text = ""
	
	if(my_party.left):
		psc_left.texture_normal=my_party.left.tex
		t += my_party.left.title + "\n\t" + str(my_party.left.c_hp) + "/" + str(my_party.left.max_hp)
		t += "\n\t" + str(my_party.left.tags) 
		t += "\n\n"
		selected_unit = my_party.left
	if(my_party.mid):
		psc_mid.texture_normal=my_party.mid.tex
		t += my_party.mid.title + "\n\t" + str(my_party.mid.c_hp) + "/" + str(my_party.mid.max_hp)
		t += "\n\t" + str(my_party.mid.tags)
		t += "\n\n"
		if(!my_party.left):
			selected_unit = my_party.mid
		
	if(my_party.right):
		psc_right.texture_normal=my_party.right.tex
		t += my_party.right.title + "\n\t" + str(my_party.right.c_hp) + "/" + str(my_party.right.max_hp)
		t += "\n\t" + str(my_party.right.tags)
		if(!my_party.left and !my_party.mid):
			selected_unit = my_party.right
	ilab.text = t

func set_buttons(setup:MenuPage):
	menu_page = setup
	var spellbutton = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/SelectSpellsButton")
	var actionbutton= get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/SelectActionsButton")
	var returnbutton= get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/Button_return")
	var mb = [spellbutton,actionbutton]
	var sb1 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton1")
	var sb2 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton2")
	var sb3 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton3")
	var sb4 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton4")
	var sb = [sb1,sb2,sb3,sb4]
	
	if(setup == MenuPage.MAIN):
		for b in mb:
			b.visible = true
		for s in sb:
			s.visible = false

	if(setup == MenuPage.SPELLS):
		for b in mb:
			b.visible = false
		for s in sb:
			s.visible = true
	if(setup == MenuPage.ACTIONS):
		for b in mb:
			b.visible = false
		for s in sb:
			s.visible = true
		
	load_spells(selected_unit)
	
func load_spells(u : Unit):
	var sb1 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton1")
	var sb2 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton2")
	var sb3 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton3")
	var sb4 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton4")
	var sb = [sb1,sb2,sb3,sb4]
	
	var i =0 
	for s in u.spells:
		if(menu_page == MenuPage.SPELLS):
			sb[i].visible=true
		sb[i].text = s
		i += 1
	while(i < sb.size()):
		sb[i].visible = false
		i += 1

func select_unit(u : Unit):
	var itr = get_node("BG_ColorRect/Info_ColorRect/InfoTextureRect")
	itr.texture = u.tex
	
	load_spells(u)
	
	pass

func _on_select_spells_button_pressed():
	set_buttons(MenuPage.SPELLS)

func _on_select_actions_button_pressed():
	set_buttons(MenuPage.ACTIONS)
	
func _on_button_return_pressed():
	if(menu_page == MenuPage.MAIN):
		queue_free()
	else:
		set_buttons(MenuPage.MAIN)
		
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if(menu_page == MenuPage.SPELLS or menu_page == MenuPage.ACTIONS):
			set_buttons(MenuPage.MAIN)
			

func _on_left_party_tex_pressed():
	select_unit(my_party.left)


func _on_mid_party_tex_pressed():
	select_unit(my_party.mid)


func _on_right_party_tex_pressed():
	select_unit(my_party.right)


func _on_enemy_texture_button_pressed():
	var itr = get_node("BG_ColorRect/Info_ColorRect/InfoTextureRect")
	#itr.texture = enemy.tex
	pass # Replace with function body.
