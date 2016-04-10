#------------------------------------------------------------------------------#
# myk - Scene Skill                                                            #
# Version 1.0                                                                  #
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
# This script can change your usual skill scene with another new layout, you   #
# can also Add a background if you want.                                       #
#------------------------------------------------------------------------------#
module MiraiSkill
#------------------------------------------------------------------------------#
# EDIT THOSE BELOW IF YOU WANT                                                 #
#------------------------------------------------------------------------------#

  #This is Window Opacity, turn this to 0 to make your window disappear
  #Max is 255
  OP = 255
  BackgroundName = " "          #Name of the Background, turn this to blank(" ")
                                #will change the background to default
                                
  SkillTypeValue = 2            #How many is the Skill Type?
  SkillListColumn = 1           #Change the Skill List's Column
  
#------------------------------------------------------------------------------#
# Editting anything past this point may potentially result in causing          #
# computer damage, incontinence, explosion of user's head, coma, death, and/or #
# halitosis so edit at your own risk.                                          #
#------------------------------------------------------------------------------#  
end


class Window_SkillStatus < Window_Base
  
  def initialize(x, y)
    super(16, 32, 149, 206)
    @actor = nil
  end
  
  def refresh
    contents.clear
    return unless @actor
    draw_actor_face(@actor, 0, 0)
    draw_actor_simple_status(@actor, 0, line_height / 2)
  end
  
  def draw_actor_simple_status(actor, x, y)
    draw_actor_name(actor, x + 1, y + 100)
    draw_actor_hp(actor, x + 1, y + 124)
    draw_actor_mp(actor, x + 1, y + 148)
  end
  
end


class Window_SkillCommand < Window_Command
  
  def initialize(x, y)
    super(16, 238)
    @actor = nil
  end
  
  def window_width
    return 149
  end
  
  def visible_line_number
    return MiraiSkill::SkillTypeValue
  end
  
end

class Scene_Skill < Scene_ItemBase

  if MiraiSkill::BackgroundName == " "
    def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = SceneManager.background_bitmap
    @background_sprite.color.set(16, 16, 16, 128)
    end
  else
    def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = Cache.load_bitmap("Graphics/Pictures/", MiraiSkill::BackgroundName)
    @background_sprite.z = -10
    end
  end
  
  def create_help_window
    @help_window = Window_Help.new(1)
    @help_window.viewport = @viewport
    @help_window.x = 0
    @help_window.y = 416 - @help_window.height
    @help_window.opacity = MiraiSkill::OP
  end
  
  def create_item_window
    @item_window = Window_SkillList.new(208, 43, 320, 256)
    @item_window.actor = @actor
    @item_window.viewport = @viewport
    @item_window.help_window = @help_window
    @item_window.set_handler(:ok,     method(:on_item_ok))
    @item_window.set_handler(:cancel, method(:on_item_cancel))
    @command_window.skill_window = @item_window
  end
  
  alias com create_command_window
  def create_command_window
    com
    @command_window.opacity = MiraiSkill::OP
  end

  alias stat create_status_window
  def create_status_window
    stat
    @status_window.opacity = MiraiSkill::OP
  end

  alias itwin create_item_window
  def create_item_window
    itwin
    @item_window.opacity = MiraiSkill::OP
  end
  
end

class Window_SkillList < Window_Selectable
  
  def col_max
    return MiraiSkill::SkillListColumn
  end
  
end

#------------------------------------------------------------------------------#
# END OF FILE                                                                  #
#------------------------------------------------------------------------------#