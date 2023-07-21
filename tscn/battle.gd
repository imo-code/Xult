extends Node2D

var my_party : Party
var menu_page : MenuPage
var selected_unit : Unit
var enemy_party : Party
var enemy : Unit
var active : bool

enum MenuPage {
	MAIN,
	ACTIONS,
	SPELLS
}

# Called when the node enters the scene tree for the first time.
func _ready():
#	var sb1 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton1")
#	var sb2 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton2")
#	var sb3 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton3")
#	var sb4 = get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton4")
#	var sb = [sb1,sb2,sb3,sb4]
	
	active = true
	#visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func setParty(playerparty:Party):
	my_party = playerparty

func setEnemyParty(enemies:Party):
	enemy_party = enemies
	enemy = enemies.mid

func loadGUI():
	#declaring unit textures
	var psc_left = get_node("BG_ColorRect/Player_ColorRect/PlayerSpriteContainer/LeftPartyTex")
	var psc_mid = get_node("BG_ColorRect/Player_ColorRect/PlayerSpriteContainer/MidPartyTex")
	var psc_right = get_node("BG_ColorRect/Player_ColorRect/PlayerSpriteContainer/RightPartyTex")
	var psc_enemy_mid = get_node("BG_ColorRect/Enemy_ColorRect/EnemySpriteContainer/EnemyTextureButton")
	#declaring bars
	var pbHeat = get_node("BG_ColorRect/Info_ColorRect/ProgressBarHeat")
	
	#declaring unit stats
	var itex = get_node("BG_ColorRect/Info_ColorRect/InfoTextureRect")
	var ilab = get_node("BG_ColorRect/Info_ColorRect/InfoRichTextLabel")
	
	ilab.text = ""
	pbHeat.visible = true
	pbHeat.value = 33
	#enemy party
	psc_enemy_mid.texture_normal = enemy_party.mid.tex
	select_unit(enemy_party.mid)
	#my party
	if(my_party.left):
		psc_left.texture_normal=my_party.left.tex
	if(my_party.mid):
		psc_mid.texture_normal=my_party.mid.tex
	if(my_party.right):
		psc_right.texture_normal=my_party.right.tex
	update_bars()

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
	
func load_spells(u : Unit):
	var sb = [get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton1"),
			get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton2"),
			get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton3"),
			get_node("BG_ColorRect/Menu_ColorRect/Menu_MenuBar/spellButton4")]
	var i =0 
	var list = u.spells
	if(menu_page == MenuPage.ACTIONS):
		#list = u.actions
		#TODO make actions work like spells, but disable the unit for the turn
		pass
	for s in list:
		if(menu_page == MenuPage.SPELLS or menu_page == MenuPage.ACTIONS):
			sb[i].visible = true
			sb[i].disabled = false
			if(!u.is_mine):
				sb[i].disabled = true
		sb[i].text = Global.Spell_Enum.keys()[s]
		i += 1
	while(i < sb.size()):
		sb[i].visible = false
		i += 1

func select_unit(u : Unit):
	var itr = get_node("BG_ColorRect/Info_ColorRect/InfoTextureRect")
	var infolabel = get_node("BG_ColorRect/Info_ColorRect/InfoRichTextLabel")
	selected_unit = u 
	itr.texture = u.tex
	var text = u.title + "\n\nqualities\n"
	for t in u.tags:
		text += "\t" + str(t) + "\n"
	
	infolabel.text = text
	load_spells(selected_unit)

func update_bars():
	#declaring bars
	var pbHPL = get_node("BG_ColorRect/Player_ColorRect/LeftProgressBarHP")
	var pbREL = get_node("BG_ColorRect/Player_ColorRect/LeftProgressBarRes")
	var pbHPM = get_node("BG_ColorRect/Player_ColorRect/MidProgressBarHP")
	var pbREM = get_node("BG_ColorRect/Player_ColorRect/MidProgressBarRes")
	var pbHPR = get_node("BG_ColorRect/Player_ColorRect/RightProgressBarHP")
	var pbRER = get_node("BG_ColorRect/Player_ColorRect/RightProgressBarRes")
	var pbHPenemyMid = get_node("BG_ColorRect/Enemy_ColorRect/ProgressBarEnemyHPmid")
	
	pbHPenemyMid.max_value = enemy_party.mid.max_hp
	pbHPenemyMid.value = enemy_party.mid.c_hp
	
	if(my_party.left):
		pbHPL.visible = true
		pbHPL.max_value = my_party.left.max_hp
		pbHPL.value = my_party.left.c_hp
		pbREL.visible = true
		pbREL.max_value = my_party.left.max_manah
		pbREL.value = my_party.left.manah
	if(my_party.mid):
		pbHPM.visible = true
		pbHPM.max_value = my_party.mid.max_hp
		pbHPM.value = my_party.mid.c_hp
		pbREM.visible = true
		pbREM.max_value = my_party.mid.max_manah
		pbREM.value = my_party.mid.manah
	if(my_party.right):
		pbHPR.visible = true
		pbHPR.max_value = my_party.right.max_hp
		pbHPR.value = my_party.right.c_hp
		pbRER.visible = true
		pbRER.max_value = my_party.right.max_manah
		pbRER.value = my_party.right.manah

func _on_select_spells_button_pressed():
	set_buttons(MenuPage.SPELLS)
	load_spells(selected_unit)

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
#	var itr = get_node("BG_ColorRect/Info_ColorRect/InfoTextureRect")
	select_unit(enemy_party.mid)
	pass # Replace with function body.


func _on_spell_button_1_pressed():
	if(menu_page == MenuPage.SPELLS):
		var my_spell = selected_unit.spells[0] #t: Spell_Enum
		Spells.cast_spell(my_party,enemy_party,selected_unit,enemy_party.mid,my_spell) #TODO : change 4th arg to target
	update_bars()


func _on_spell_button_2_pressed():
	if(menu_page == MenuPage.SPELLS):
		var my_spell = selected_unit.spells[1] #t: Spell_Enum
		Spells.cast_spell(my_party,enemy_party,selected_unit,enemy_party.mid,my_spell) #TODO : change 4th arg to target
	update_bars()	

func _on_spell_button_3_pressed():
	if(menu_page == MenuPage.SPELLS):
		var my_spell = selected_unit.spells[2]#t: Spell_Enum
		Spells.cast_spell(my_party,enemy_party,selected_unit,enemy_party.mid,my_spell) #TODO : change 4th arg to target
	update_bars()

func _on_spell_button_4_pressed():
	if(menu_page == MenuPage.SPELLS):
		var my_spell = selected_unit.spells[3] #t: Spell_Enum
		Spells.cast_spell(my_party,enemy_party,selected_unit,enemy_party.mid,my_spell) #TODO : change 4th arg to target
	update_bars()
