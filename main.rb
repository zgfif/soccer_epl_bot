require 'telegram/bot'
require_relative 'last_result'

TOKEN = ENV['TELEGRAM_TOKEN']

def help_text
  "Commands: \n
  /start - show specific keyboard;\n
  /england - show English Premier League result;\n
  /ukraine - show Ukrainian Premier League result;\n
  /help - list of available commands.\n
  /stop - hide specific keyboard."
end

Telegram::Bot::Client.run(TOKEN, logger: Logger.new($stderr)) do |bot|
  bot.logger.info('Bot has been started')

  bot.listen do |message|
    case message.text
    when '/start'
      kb = Telegram::Bot::Types::ReplyKeyboardMarkup.new keyboard: ['/england'], one_time_keyboard: true

      bot.api.send_message(chat_id: message.chat.id, text: 'Привет, какой результат интересует?', reply_markup: kb)
    when '/stop'
      hide_kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)

      bot.api.send_message(chat_id: message.chat.id, text: 'До встречи', reply_markup: hide_kb)
    when '/england'
      bot.api.send_message(chat_id: message.chat.id, text: LastResult.new.perform)
    when '/help'
      bot.api.send_message(chat_id: message.chat.id, text: help_text)
    end
  end
end
