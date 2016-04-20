#------------------------------------------------------------------------------#
# myk - YEA Battle Addon - Face Battler                                        #
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
# This script basically changes the face in original YEA Battle Engine to a    #
# battler.                                                                     #
#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
# Editting anything past this point may potentially result in causing          #
# computer damage, incontinence, explosion of user's head, coma, death, and/or #
# halitosis so edit at your own risk.                                          #
#------------------------------------------------------------------------------#
class Window_BattleStatus < Window_Selectable

alias bs_init initialize
def initialize
    bs_init
    self.opacity = 0
end

  def draw_face(face_name, face_index, dx, dy, enabled = true)
    bitmap = Cache.face(face_name + "-" + (face_index + 1).to_s)
    fx = [(96 - item_rect(0).width + 1) / 2, 0].max
    fy = face_index / 4 * 96 + 2
    fw = [item_rect(0).width - 4, 92].min
    rect = Rect.new(fx, fy, fw, 92)
    rect = Rect.new(face_index % 4 * 96 + fx, fy, fw, 92)
    contents.blt(dx, dy, bitmap, rect, enabled ? 255 : translucent_alpha)
    bitmap.dispose
  end
  
  def draw_actor_name(actor, dx, dy, dw = 112)
    reset_font_settings
    contents.font.size = YEA::BATTLE::BATTLESTATUS_NAME_FONT_SIZE
    change_color(hp_color(actor))
    draw_text(dx+2, dy+48, dw-24, line_height, actor.name)
  end
end