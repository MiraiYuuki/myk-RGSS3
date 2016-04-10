#------------------------------------------------------------------------------#
# myk - Scene Item                                                             #
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
# This script can change your usual item scene with another new layout, you can#
# also Add a background if you want.                                           #
#------------------------------------------------------------------------------#
module MiraiItem
#------------------------------------------------------------------------------#
# EDIT THOSE BELOW IF YOU WANT                                                 #
#------------------------------------------------------------------------------#  
  #This is Window Opacity, turn this to 0 to make your window disappear
  #Max is 255
  OP = 255
  BackgroundName = " "          #Name of the Background, turn this to blank(" ")
                                #will change the background to default
  
  CategoryWidth = 408           #Change the Category Window's width
  CategoryColumn = 3            #How many Command to be shown?
                                #(recommended 3 or 4)
  
  ItemListColumn = 1            #Change the List Item's Column
#------------------------------------------------------------------------------#
# Editting anything past this point may potentially result in causing          #
# computer damage, incontinence, explosion of user's head, coma, death, and/or #
# halitosis so edit at your own risk.                                          #
#------------------------------------------------------------------------------#  
end


class Window_ItemCategory < Window_HorzCommand
  
  def window_width
    return MiraiItem::CategoryWidth
  end
  
  def col_max
    return MiraiItem::CategoryColumn
  end
  
end

class Window_ItemList < Window_Selectable
  
  def col_max
    return MiraiItem::ItemListColumn
  end
  
end


class Scene_Item < Scene_ItemBase

 if MiraiItem::BackgroundName == " "
    def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = SceneManager.background_bitmap
    @background_sprite.color.set(16, 16, 16, 128)
  end
  else
  def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = Cache.load_bitmap("Graphics/Pictures/", MiraiItem::BackgroundName)
    @background_sprite.z = -10
  end
  end
  
 def create_help_window
      @help_window = Window_Help.new(1)
      @help_window.viewport = @viewport
      @help_window.x = 0
      @help_window.height = 48
      @help_window.y = 416 - @help_window.height
      @help_window.opacity = MiraiItem::OP
 end
  
 
  def create_category_window
    @category_window = Window_ItemCategory.new
    @category_window.viewport = @viewport
    @category_window.help_window = @help_window
    @category_window.x = (Graphics.width - @category_window.width)/2
    @category_window.y = 80 - @category_window.height
    @category_window.set_handler(:ok,     method(:on_category_ok))
    @category_window.set_handler(:cancel, method(:return_scene))
    @category_window.opacity = MiraiItem::OP
  end

  def create_item_window
    wy = Graphics.height/2 - (256/2)
    @item_window = Window_ItemList.new(@category_window.x, wy, 408, 256)
    @item_window.viewport = @viewport
    @item_window.help_window = @help_window
    @item_window.set_handler(:ok,     method(:on_item_ok))
    @item_window.set_handler(:cancel, method(:on_item_cancel))
    @category_window.item_window = @item_window
    @item_window.opacity = MiraiItem::OP
  end
 
end

#------------------------------------------------------------------------------#
# END OF FILE                                                                  #
#------------------------------------------------------------------------------#