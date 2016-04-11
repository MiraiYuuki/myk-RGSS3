#------------------------------------------------------------------------------#
# myk - Scene Status                                                           #
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
# This script can change your usual status scene with another new layout, you  #
# can also Add a background if you want.                                       #
#------------------------------------------------------------------------------#
module MiraiStatus
#------------------------------------------------------------------------------#
# EDIT THOSE BELOW IF YOU WANT                                                 #
#------------------------------------------------------------------------------#

  #This is Window Opacity, turn this to 0 to make your window disappear
  #Max is 255
  OP = 255
  BackgroundName = " "          #Name of the Background, turn this to blank(" ")
                                #will change the background to default

#------------------------------------------------------------------------------#
# Editting anything past this point may potentially result in causing          #
# computer damage, incontinence, explosion of user's head, coma, death, and/or #
# halitosis so edit at your own risk.                                          #
#------------------------------------------------------------------------------#
end

class Window_Status < Window_Selectable

   def refresh
      contents.clear
      self.contents.font.size = 18
      self.contents.font.bold = true
      draw_actor_name(@actor, 8, y)
      draw_actor_class(@actor, 164, y)
      draw_actor_face(@actor, 24, 28)
      draw_basic_info(24, 124)
      draw_exp_info(24, 212)
      draw_parameters(313, 156)
      draw_equipments(312, 22)
      draw_horz_line(line_height * 13)
      draw_block4   (line_height * 14)
    end

    def draw_block4(y)
    draw_description(4, y)
    end

    def draw_basic_info(x, y)
    draw_actor_level(@actor, x, y + line_height * 0)
    draw_actor_icons(@actor, 128, y + line_height * 0)
    draw_actor_hp(@actor, x, y + 4 + line_height * 1)
    draw_actor_mp(@actor, x, y + 4 + line_height * 2)
    end
  
    def draw_actor_name(actor, x, y)
    draw_text(x, y, width, line_height, "Name :")
    change_color(hp_color(actor))
    draw_text(x + 64, y, width, line_height, actor.name)
    end
  
    def draw_actor_class(actor, x, y)
    draw_text(x, y, width, line_height, "Class :")
    change_color(normal_color)
    draw_text(x + 64, y, width, line_height, actor.class.name)
    end
end
  
class Scene_Status < Scene_MenuBase
  
  alias statstart start
  def start
    statstart
    @status_window.opacity = MiraiStatus::OP
  end
  
  if MiraiStatus::BackgroundName == " "
    def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = SceneManager.background_bitmap
    @background_sprite.color.set(16, 16, 16, 128)
    end
  else
    def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = Cache.load_bitmap("Graphics/Pictures/", MiraiStatus::BackgroundName)
    @background_sprite.z = -10
    end
  end
  
end

#------------------------------------------------------------------------------#
# END OF FILE                                                                  #
#------------------------------------------------------------------------------#