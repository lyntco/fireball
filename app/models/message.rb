# == Schema Information
#
# Table name: messages
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  game_id             :integer
#  chat_id             :integer
#  image               :string(255)
#  language_from       :string(255)
#  language_to         :string(255)
#  input_text          :string(255)
#  translation         :string(255)
#  pronounciation_text :string(255)
#  sound               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

class Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :game
  belongs_to :user

  def translate_text
    current_user = User.find self.user_id
    translate_me = URI.encode( self.input_text )
    url = 'https://www.googleapis.com/language/translate/v2?key='
    url += API_KEY
    url += '&q=' + translate_me
    url += '&source=' + current_user.native_language
    if chat.present?
      url += '&target=' + chat.language
    elsif game.present?
      url += '&target=' + game.language
    end
    response = HTTParty.get( url ).to_json
    response = JSON.parse(response)
    translation = response['data']['translations'].first['translatedText']
    self.translation = translation
  end

  def emoticon
    { "autumn" => "emoticons/autumn.png",
      "fall" =>  "emoticons/autumn.png",
      "christmas" => "emoticons/christmas.png",
      "chrissy" => "emoticons/christmas.png",
      "xmas" => "emoticons/christmas.png",
      "drink" => "emoticons/drink.png",
      "party" => "emoticons/drink.png",
      "partying" => "emoticons/drink.png",
      "drinking" => "emoticons/drink.png",
      "fireball" => "emoticons/fireball.png",
      "gift" => "emoticons/gift.png",
      "present" => "emoticons/gift.png",
      "presents" => "emoticons/gift.png",
      "i-m-happy" => "emoticons/happy.png",
      "happy" => "emoticons/happy.png",
      "stoked" => "emoticons/happy.png",
      "rich" => "emoticons/rich.png",
      "money" => "emoticons/rich.png",
      "dollar-bills" => "emoticons/rich.png",
      "them-dollar-bills" => "emoticons/rich.png",
      "spring" => "emoticons/spring.png",
      "picnic" => "emoticons/spring.png",
      "summer" => "emoticons/summer.png",
      "beach" => "emoticons/summer.png",
      "thirsty" => "emoticons/thirsty.png",
      "i-m-thirsty" => "emoticons/thirsty.png",
      "water" => "emoticons/thirsty.png",
      "toilet" => "emoticons/toilet.png",
      "poo" => "emoticons/toilet.png",
      "pee" => "emoticons/toilet.png",
      "wink" => "emoticons/wink.png",
      "yoy" => "emoticons/wink.png",
      "hi" => "emoticons/wink.png",
      "winter" => "emoticons/winter.png",
      "work" => "emoticons/work.png",
      "office" => "emoticons/work.png",
      "work" => "emoticons/work.png",
      "happy-birthday" => "emoticons/happybirthday.png",
      "happy-new-year" => "emoticons/happynewyear.png",
      "i-m-hungry" => "emoticons/hungry.png",
      "i-don-t-know" => "emoticons/idontknow.png",
      "i-don-t-understand" => "emoticons/idontknow.png",
      "huh" => "emoticons/idontknow.png",
      "peng" =>  "emoticons/peng.png",
      "hello" =>  "emoticons/peng.png",
      "music" =>  "emoticons/music.png",
      "dance" => "emoticons/music.png",
      "dancing" => "emoticons/music.png",
      "i-love-you" => "emoticons/iloveyou.png",
      "i-like-you" => "emoticons/ilikeyou.png",
      "pissed-off" => "emoticons/pissedoff.png",
      "run" => "emoticons/run.png",
      "running" => "emoticons/run.png",
      "jogging" => "emoticons/run.png",
      "working-out" => "emoticons/run.png",
      "i-m-sad" => "emoticons/sad.png",
      "sad" => "emoticons/sad.png",
      "lonely" => "emoticons/sad.png",
      "i-m-shy" => "emoticons/shy.png",
      "shy" => "emoticons/shy.png",
      "i-m-sick" => "emoticons/sick.png",
      "feel-shit" => "emoticons/sick.png",
      "sick" => "emoticons/sick.png",
      "i-m-smoking" => "emoticons/smoke.png",
      "smoke" => "emoticons/smoke.png",
      "study" => "emoticons/study.png",
      "cigarette" => "emoticons/smoke.png",
      "durry" => "emoticons/smoke.png",
      "boss" => "emoticons/smoke.png",
      "i-m-studying" => "emoticons/study.png",
      "surprise" => "emoticons/surprise.png",
      "holy-shit" => "emoticons/surprise.png",
      "surprised" => "emoticons/surprise.png",
      "surprising" => "emoticons/surprise.png",
      "what" => "emoticons/what.png",
      "win" => "emoticons/win.png",
      "won" => "emoticons/win.png",
      "angry" => "emoticons/angry.png",
      "drunken" => "emoticons/drunken.png",
      "wasted" => "emoticons/drunken.png",
      "shit-faced" => "emoticons/drunken.png",
      "blasted" => "emoticons/drunken.png",
      "fuck-eyed" => "emoticons/drunken.png",
      "blind" => "emoticons/drunken.png",
      "call" => "emoticons/call.png",
      "phone" => "emoticons/call.png"
    }

  end

  def match_emoticon
    string = self.input_text.parameterize
    self.image = self.emoticon[string] if self.emoticon.include?(string)
  end
end
