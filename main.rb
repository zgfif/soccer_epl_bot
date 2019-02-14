require 'telegram/bot'

TOKEN = ENV['TELEGRAM_TOKEN']

ANSWERS = ['Yes', 'No', 'Maybe']

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start', '/start start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Hello, #{message.from.first_name}"
      )
    when '/stop'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Bye, #{message.from.first_name}"
      )
    else
      bot.api.send_message(
        chat_id: message.chat.id,
        text: ANSWERS.sample
      )
    end
  end
end
