#------------------------------------------------------------------------------#
# myk - Scene Equip                                                            #
# Version 1.2                                                                  #
#------------------------------------------------------------------------------#
# Author : Mirai                                                               #
#------------------------------------------------------------------------------#
# Terms of Use:                                                                #
# Credit me, as Mirai or Evananda Satriya (choose one,                         #
# but if you want both then go ahead.                                          #
#------------------------------------------------------------------------------#
# Instructions:                                                                #
# Place this under materials and above main.                                   #
#------------------------------------------------------------------------------#
# Introduction:                                                                #
# This script can change your usual equip scene with another new layout, you   #
# can also Add a background if you want.                                       #
#------------------------------------------------------------------------------#
module MiraiEquip
#------------------------------------------------------------------------------#
# EDIT THOSE BELOW IF YOU WANT                                                 #
#------------------------------------------------------------------------------#

  #This is Window Opacity, turn this to 0 to make your window disappear
  #Max is 255
  OP = 255
  
  ArrowIcon = 0                 #This is the Arrow Icon in the Parameter
                                #Window, change this 0 to change the arrow
                                #icon to default
                                
  IconUP = 113                  #This is the up arrow icon when the parameter 
                                #increased
                                
  IconDW = 114                  #This is the down arrow icon when the parameter
                                #decreased
                                
  BackgroundName = " "          #Name of the Background, turn this to blank(" ")
                                #will change the background to default

#------------------------------------------------------------------------------#
# Editting anything past this point may potentially result in causing          #
# computer damage, incontinence, explosion of user's head, coma, death, and/or #
# halitosis so edit at your own risk.                                          #
#------------------------------------------------------------------------------#   
end

class Window_EquipCommand < Window_HorzCommand
  
  def initialize(x, y, width)
    @window_width = 312
    super(216, 16)
  end
  
end

class Window_EquipSlot < Window_Selectable
  
  def initialize(x, y, width)
    super(229, 80, 286, window_height)
    @actor = nil
    refresh
  end
  
  def visible_line_number
    return 5
  end
  
end

class Window_EquipItem < Window_ItemList
  
  def initialize(x, y, width, height)
    super(216, 232, 312, 128)
    @actor = nil
    @slot_id = 0
  end
  
end

class Window_EquipStatus < Window_Base
  
  def initialize(x, y)
    super(16, y, 156, window_height) #originwidth = 156
    @actor = nil
    @temp_actor = nil
    refresh
  end
  
  def draw_item(x, y, param_id)
    draw_param_name(x + 4, y, param_id)
    draw_current_param(x + 36, y, param_id) if @actor
    draw_new_param(x + 92, y, param_id) if @temp_actor
    draw_right_arrow(2, x + 68, y, param_id) if @temp_actor
  end
  
  def draw_right_arrow(icon_index, x, y, param_id)
    new_value = @temp_actor.param(param_id)
    change_color(system_color)
    if new_value > @actor.param(param_id)
      draw_icon(MiraiEquip::IconUP, x, y, line_height)
    elsif new_value < @actor.param(param_id)
      draw_icon(MiraiEquip::IconDW, x, y, line_height)
    else
      if MiraiEquip::ArrowIcon == 0
      draw_text(x, y, 22, line_height, "→", 1)
      else
      draw_icon(MiraiEquip::ArrowIcon, x, y, line_height)
      end
    end
    
  end

end

class Scene_Equip < Scene_MenuBase

  if MiraiEquip::BackgroundName == " "
    def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = SceneManager.background_bitmap
    @background_sprite.color.set(16, 16, 16, 128)
  end
  else
  def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = Cache.load_bitmap("Graphics/Pictures/", MiraiEquip::BackgroundName)
    @background_sprite.z = -10
  end
  end

  def create_help_window
    @help_window = Window_Help.new(1)
    @help_window.viewport = @viewport
    @help_window.x = 0
    @help_window.y = 416 - @help_window.height
    @help_window.opacity = MiraiEquip::OP
  end
  
  alias eqstat create_status_window
  def create_status_window
    eqstat
    @status_window.opacity = MiraiEquip::OP
  end
  
  alias eqcom create_command_window
  def create_command_window
    eqcom
    @command_window.opacity = MiraiEquip::OP
  end
  
  alias eqslot create_slot_window
  def create_slot_window
    eqslot
    @slot_window.opacity = MiraiEquip::OP
  end
  
  alias eqitem create_item_window
  def create_item_window
    eqitem
    @item_window.opacity = MiraiEquip::OP
  end
  
end

#------------------------------------------------------------------------------#
# END OF FILE                                                                  #
#------------------------------------------------------------------------------#