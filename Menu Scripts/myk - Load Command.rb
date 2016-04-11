#------------------------------------------------------------------------------#
# myk - Load Command                                                           #
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
# Add a Load command to your menu                                              #
#------------------------------------------------------------------------------#
module Vocab
#------------------------------------------------------------------------------#
# EDIT THAT BELOW IF YOU WANT                                                  #
#------------------------------------------------------------------------------#
   Load = "Load"          #This is the load vocab, you can change it if you want
#------------------------------------------------------------------------------#
# Editting anything past this point may potentially result in causing          #
# computer damage, incontinence, explosion of user's head, coma, death, and/or #
# halitosis so edit at your own risk.                                          #
#------------------------------------------------------------------------------#
end

class Window_MenuCommand < Window_Command
  
  def make_command_list
    add_main_commands
    add_formation_command
    add_original_commands
    add_save_command
    add_load_command
    add_game_end_command
  end
  
  def add_load_command
    add_command(Vocab::Load, :load)
  end
  
end

class Scene_Menu < Scene_MenuBase
  
  alias default_command create_command_window
  def create_command_window
    default_command
    @command_window.set_handler(:load,      method(:command_load))
  end
  
  def command_load
    SceneManager.call(Scene_Load)
  end
  
end
