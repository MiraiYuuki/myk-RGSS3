#------------------------------------------------------------------------------#
# myk - Scene Menu                                                             #
# Version 1.0                                                                  #
#------------------------------------------------------------------------------#
# Author : Mirai                                                               #
#------------------------------------------------------------------------------#
# Terms of Use:                                                                #
# Credit me, as Mirai or Evananda Satriya (choose one,                         #
# but if you want both then go ahead.                                          #
# also thanks to Galv's menu layout for some                                   #
# reference.                                                                   #
#------------------------------------------------------------------------------#
# Instructions:                                                                #
# Place this under materials and above main.                                   #
#------------------------------------------------------------------------------#
# Introduction:                                                                #
# This script can change your usual menu with another new layout, you can also #
# Add a background if you want.                                                #
#------------------------------------------------------------------------------#
module MiraiMain
#------------------------------------------------------------------------------#
# EDIT THOSE BELOW IF YOU WANT                                                 #
#------------------------------------------------------------------------------#

  #This is Window Opacity, turn this to 0 to make your window disappear
  #Max is 255
  OP = 255
  
  #How many player that should be displayed?
  DisplayCharacter = 3
  
  StatusX = 1             #Change the Status Window's X
  StatusY = 30            #Change the Status Window's Y
  StatusWidth = 412       #Change the Status Window's Width
  StatusHeight = 356      #Change the Status Window's Height
  StatusFontSize = 18     #The Font Size in the Status Window
  StatusFontBold = true   #Does the font bold in the Status Window? (true/false)
  
  CommandX = 414          #Change the Command Window's X
  CommandY = 30           #Change the Command Window's Y
  CommandWidth = 130      #Change the Command Window's Width

  TimeGoldXLeft = 0       #Change the Playtime and Gold Window's X from bottom
  TimeGoldYBottom = 30    #Change the Playtime and Gold Window's Y from bottom
  
  GoldWidth = 130         #Change the Gold Window's Width
  PlaytimeWidth = 130     #Change the Playtime Window's Width
  
  PortraitHeight = 342    #The Portrait's Height
  
  BackgroundName = " "    #Name of the Background, turn this to blank(" ")
                          #will change the background to default
  
#------------------------------------------------------------------------------#
# Editting anything past this point may potentially result in causing          #
# computer damage, incontinence, explosion of user's head, coma, death, and/or #
# halitosis so edit at your own risk.                                          #
#------------------------------------------------------------------------------#
end

class Scene_MenuBase < Scene_Base

  def dispose_backgroundsss
    @menubg.dispose
  end
    def dispose_background
    @background_sprite.dispose
  end
  
end


class Window_MenuCommand < Window_Command
  
  def initialize
    super(MiraiMain::CommandX, MiraiMain::CommandY)
    select_last
  end
 
  def window_width
    return MiraiMain::CommandWidth
  end

  def make_command_list
    add_main_commands
    add_original_commands
    add_save_command
    add_game_end_command
  end
  
end

class Window_MenuStatus < Window_Selectable
  
  def initialize(x, y)
    super(MiraiMain::StatusX, MiraiMain::StatusY, MiraiMain::StatusWidth, MiraiMain::StatusHeight)
    @pending_index = -1
    self.contents.font.size = MiraiMain::StatusFontSize
    self.contents.font.bold = MiraiMain::StatusFontBold
    refresh
  end
  
  def item_height
    (height - standard_padding * 2)
  end
  
  def draw_face2(face_name, face_index, x, y, enabled = true)
    bitmap = Cache.picture(face_name + "-" + (face_index + 1).to_s)
    rect = Rect.new(100, -70 + 0, col_width + tweak, MiraiMain::PortraitHeight)
    contents.blt(x, y, bitmap, rect, enabled ? 255 : translucent_alpha)
    bitmap.dispose
  end

  def tweak
    if MiraiMain::DisplayCharacter <= 3
      return -2
    else
      return 0
    end
  end
  
  def col_width
    window_width / MiraiMain::DisplayCharacter - standard_padding - 2
  end
  
  def draw_actor_face2(actor, x, y, enabled = true)
    draw_face2(actor.face_name, actor.face_index, x, y, enabled)
  end
  
  def draw_item(index)
    actor = $game_party.members[index]
    enabled = $game_party.battle_members.include?(actor)
    rect = item_rect(index)
    draw_item_background(index)
    draw_actor_face2(actor, rect.x + 1, rect.y + 1, enabled)
    draw_actor_simple_status(actor, rect.x, rect.y)
  end
  
  def draw_actor_simple_status(actor, x, y)
    draw_actor_name(actor, x, y)
    draw_actor_level(actor, x, y + line_height * 1)
    draw_actor_icons(actor, x, y + line_height * 2)
    draw_actor_hp(actor, x, y + line_height * 12)
    draw_actor_mp(actor, x, y + line_height * 13)
  end
  
  def draw_actor_hp(actor, x, y, width = col_width)
    draw_gauge(x, y, width, actor.hp_rate, hp_gauge_color1, hp_gauge_color2)
    change_color(system_color)
    draw_text(x, y, 30, line_height, Vocab::hp_a)
    draw_current_and_max_values(x, y, width, actor.hp, actor.mhp,
    hp_color(actor), normal_color)
  end
 
  def draw_actor_mp(actor, x, y, width = col_width)
    draw_gauge(x, y, width, actor.mp_rate, mp_gauge_color1, mp_gauge_color2)
    change_color(system_color)
    draw_text(x, y, 30, line_height, Vocab::mp_a)
    draw_current_and_max_values(x, y, width, actor.mp, actor.mmp,
    mp_color(actor), normal_color)
  end
  
  def visible_line_number
    return 1
  end
  
  def col_max
    return MiraiMain::DisplayCharacter
  end
  
  def spacing
    return 8
  end
  
  def contents_width
    (item_width + spacing) * item_max - spacing
  end
  
  def contents_height
    item_height
  end
  
   def top_col
    ox / (item_width + spacing)
  end
  
  def top_col=(col)
    col = 0 if col < 0
    @member_count = $game_party.members.count
    col = col_max + @member_count if col > col_max + @member_count
    self.ox = col * (item_width + spacing)
  end
  
  def bottom_col
    top_col + col_max - 1
  end
  
  def bottom_col=(col)
    self.top_col = col - (col_max - 1)
  end
  
  def ensure_cursor_visible
    self.top_col = index if index < top_col
    self.bottom_col = index if index > bottom_col
  end
  
  def item_rect(index)
    
    rect = super
    rect.x = index * (item_width + spacing)
    rect.y = 0
    rect
    
  end
  
  def alignment
    return 1
  end
  
  def cursor_down(wrap = false)
  end
  
  def cursor_up(wrap = false)
  end
  
  def cursor_pagedown
  end
  
  def cursor_pageup
  end
  
end

class Window_Gold < Window_Base

 def window_width
   return MiraiMain::GoldWidth
 end

end

class Window_Playtime < Window_Base
  
  def initialize
    super(187, 368, window_width, fitting_height(1))
    self.opacity = 255 if SceneManager.scene_is?(Scene_Menu)
    refresh
  end
  
  def window_width
    return MiraiMain::PlaytimeWidth
  end
  
  def refresh
    contents.clear
    change_color(system_color)
    change_color(normal_color)
    draw_playtime(4, contents_height - line_height, contents.width - 8, 2)
  end
  
  def open
    refresh
    super
  end
  
  def draw_playtime(x, y, width, align)
    draw_text(x, y, width, line_height, $game_system.playtime_s, align)
  end
  
  def update
    refresh
  end
  
end

class Scene_Menu < Scene_MenuBase
  
  def start
    super
    create_command_window
    create_gold_window
    create_playtime_window
    create_status_window
  end
  
  if MiraiMain::BackgroundName == " "
   def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = SceneManager.background_bitmap
    @background_sprite.color.set(16, 16, 16, 128)
   end
  else
   def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = Cache.load_bitmap("Graphics/Pictures/", MiraiMain::BackgroundName)
    @background_sprite.z = -10
   end
  end
  
  def create_gold_window
    @gold_window = Window_Gold.new
    @gold_window.x = Graphics.width - @gold_window.width - MiraiMain::TimeGoldXLeft
    @gold_window.y = Graphics.height - @gold_window.height - MiraiMain::TimeGoldYBottom
    @gold_window.opacity = MiraiMain::OP
  end
  
  def create_playtime_window
    @playtime_window = Window_Playtime.new
    @playtime_window.x = Graphics.width - @playtime_window.width - MiraiMain::TimeGoldXLeft
    @playtime_window.y = Graphics.height - @playtime_window.height - @gold_window.height - MiraiMain::TimeGoldYBottom
    @playtime_window.opacity = MiraiMain::OP
  end
  
  def create_command_window
    @command_window = Window_MenuCommand.new
    @command_window.set_handler(:item,      method(:command_item))
    @command_window.set_handler(:skill,     method(:command_personal))
    @command_window.set_handler(:equip,     method(:command_personal))
    @command_window.set_handler(:status,    method(:command_personal))
    @command_window.set_handler(:save,      method(:command_save))
    @command_window.set_handler(:game_end,  method(:command_game_end))
    @command_window.set_handler(:cancel,    method(:return_scene))
    @command_window.opacity = MiraiMain::OP
  end
  
  def create_status_window
    @status_window = Window_MenuStatus.new(@command_window.width, 0)
    @status_window.opacity = MiraiMain::OP
  end

  
end

#------------------------------------------------------------------------------#
# END OF FILE                                                                  #
#------------------------------------------------------------------------------#