#------------------------------------------------------------------------------#
# myk - Scene End                                                              #
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
# This script can change your usual end scene with another new layout, you     #
# can also Add a background if you want.                                       #
#------------------------------------------------------------------------------#
module MiraiEnd
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

class Window_GameEnd < Window_Command
  
  alias init initialize
  def initialize
    init
    self.opacity = MiraiEnd::OP
  end
  
end

class Scene_End < Scene_MenuBase
  
  if MiraiEnd::BackgroundName == " "
    def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = SceneManager.background_bitmap
    @background_sprite.color.set(16, 16, 16, 128)
    end
  else
    def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = Cache.load_bitmap("Graphics/Pictures/", MiraiEnd::BackgroundName)
    @background_sprite.z = -10
    end
  end
  
end

#------------------------------------------------------------------------------#
# END OF FILE                                                                  #
#------------------------------------------------------------------------------#