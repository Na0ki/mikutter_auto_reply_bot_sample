# -*- coding: utf-8 -*-

Plugin.create(:mikutter_auto_reply_bot_sample) do

  DEFINED_TIME = Time.new.freeze

  # load reply dictionaries
  begin
    default = YAML.load_file(File.join(__dir__, 'dic/default.yml'))
  rescue LoadError
    notice 'Could not load yml file'
  end

  on_appear do |ms|
    ms.each do |m|
      if m.message.to_s =~ /sample/ and m[:created] > DEFINED_TIME and !m.retweet?
        # select reply dic & get sample reply
        reply = default.sample

        # send reply & fav
        Service.primary.post(:message => "@#{m.user.idname} #{reply}", :replyto => m)
        m.message.favorite(true)
      end
    end
  end

end
