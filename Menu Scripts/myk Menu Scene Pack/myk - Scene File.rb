#------------------------------------------------------------------------------#
# myk - Scene File                                                             #
# Version 1.1                                                                  #
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
# This script can change your usual file scene with another new layout, you    #
# can also Add a background if you want.                                       #
#------------------------------------------------------------------------------#
module MiraiFile
#------------------------------------------------------------------------------#
# EDIT THOSE BELOW IF YOU WANT                                                 #
#------------------------------------------------------------------------------#

  #This is Window Opacity, turn this to 0 to make your window disappear
  #Max is 255
  OP = 255
  BackgroundName = " "          #Name of the Background, turn this to blank(" ")
                                #will change the background to default
                                
  SaveFileY = 1                 #Change the SaveFile Window Y
  #Recommended Setting when character enabled/true = 0
  #Recommended Setting when character disabled/false = 1
                                
  SaveFileHeight = 73           #Change the SaveFile Window Height
  #Recommended Setting when character enabled/true = 92
  #Recommended Setting when character disabled/false = 73
  
  FileMax = 5                   #How many is the file you need?
  
  VisibleMax = 5                #How many file that should be displayed?
  #Recommended Setting when character enabled/true = 4
  #Recommended Setting when character disabled/false = 5
  
  DrawCharacter = false         #draw the character?(true/false)

#------------------------------------------------------------------------------#
# Editting anything past this point may potentially result in causing          #
# computer damage, incontinence, explosion of user's head, coma, death, and/or #
# halitosis so edit at your own risk.                                          #
#------------------------------------------------------------------------------#
end

module DataManager
  def self.savefile_max
    return MiraiFile::FileMax
  end
  def self.make_save_header
    header = {}
    header[:characters] = $game_party.characters_for_savefile
    header[:playtime_s] = $game_system.playtime_s
    header[:gold_s] = $game_party.gold
    header[:location_s] = $game_map.display_name
    header
  end
end


class Window_SaveFile < Window_Base
  
  def initialize(height, index)
    super(0, index * height + MiraiFile::SaveFileY, Graphics.width, MiraiFile::SaveFileHeight)
    @file_index = index
    refresh
    @selected = false
    self.opacity = MiraiFile::OP
  end
  
  def refresh
    contents.clear
    self.contents.font.size = 18
    self.contents.font.bold = true
    change_color(normal_color)
    name = Vocab::File + " #{@file_index + 1}"
    draw_text(4, 0, 200, line_height, name)
    @name_width = text_size(name).width
    if MiraiFile::DrawCharacter == true
    draw_party_characters(152, 32)
    end
    draw_location(128, 0)
    draw_gold(0, 0)
    draw_playtime(0, 0, contents.width - 4, 2)
  end
  
  if MiraiFile::DrawCharacter == true
  def draw_party_characters(x, y)
    header = DataManager.load_header(@file_index)
    return unless header
    header[:characters].each_with_index do |data, i|
      draw_character(data[0], data[1], x + i * 48, y)
    end
  end
  end
  
  def draw_location(x, y)
    header = DataManager.load_header(@file_index)
    return unless header
    draw_text(x, y, width, height, "| #{"Location"}: #{header[:location_s]}", 0)
  end
  
  def draw_gold(x, y)
    header = DataManager.load_header(@file_index)
    return unless header
    draw_text(x, y, width, height, "#{"Gold"}: #{header[:gold_s]}", 0)
  end
  
  def draw_playtime(x, y, width, align)
    header = DataManager.load_header(@file_index)
    return unless header
    draw_text(x, y, width, height, "| #{"Playtime"}: #{header[:playtime_s]}", 2)
  end
  
end

class Scene_File < Scene_MenuBase

  def visible_max
    return MiraiFile::VisibleMax
  end
  
  alias savestart start
  def start
    savestart
    @help_window.opacity = MiraiFile::OP
  end
  
  if MiraiFile::BackgroundName == " "
    def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = SceneManager.background_bitmap
    @background_sprite.color.set(16, 16, 16, 128)
    end
  else
    def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = Cache.load_bitmap("Graphics/Pictures/", MiraiFile::BackgroundName)
    @background_sprite.z = -10
    end
  end
  
end

#------------------------------------------------------------------------------#
# END OF FILE                                                                  #
#------------------------------------------------------------------------------#