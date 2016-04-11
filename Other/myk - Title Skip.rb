#------------------------------------------------------------------------------#
# myk - Title Skip                                                             #
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
# This Script can skip your title screen, so if you want to debug your game or #
# make the evented title screen, you don't have to go to default title screen. #
#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
# Editting anything past this point may potentially result in causing          #
# computer damage, incontinence, explosion of user's head, coma, death, and/or #
# halitosis so edit at your own risk.                                          #
#------------------------------------------------------------------------------#
class Scene_Title < Scene_Base
  def start
    SceneManager.clear
    Graphics.freeze
    new_game
  end
  
  def new_game
    DataManager.setup_new_game
    $game_map.autoplay
    SceneManager.goto(Scene_Map)
  end
  
  def terminate
    SceneManager.snapshot_for_background
    Graphics.fadeout(Graphics.frame_rate)
  end
end
#------------------------------------------------------------------------------#
# END OF FILE                                                                  #
#------------------------------------------------------------------------------#