require 'telegram/bot'

class TelegramMailer
  attr_reader :record, :notice, :sender

  def initialize(record, notice, sender)
    @record = record
    @notice = notice
    @sender = sender
  end

  def send_message_to_telegram
    token = '378755776:AAH8blnBXmuqUg5zi-vMdpe3bp1ineEisk0'   

    work_day_flag = WorkDay.find_by id: record.work_day_id
    day_flag = Day.find_by id: work_day_flag.day_id
    month_flag = Month.find_by id: day_flag.month_id
    year_flag = Year.find_by id: month_flag.year_id
    chat_ids = []

    service_text = ""
    purchase_text = ""
    superadmin = User.find_by role: "superadmin"
    master_login = User.find_by(id: Master.find_by(id: work_day_flag.master_id).user_id)

    if !master_login.nil?
      master_chat_id = [master_login.telegram_chat_id] 
      chat_ids = chat_ids | master_chat_id
    end

    if sender == 2
      superadmin_chat_id = [superadmin.telegram_chat_id]

      chat_ids = chat_ids | superadmin_chat_id
    end
    

    date_text = "Дата записи: <b>#{day_flag.number_of_the_day}-#{month_flag.number}-#{year_flag.number}</b>"
    master_text = "Мастер: <b>#{Master.find_by(id: work_day_flag.master_id).decorate.master_info}</b>"
    record_text = "Запись на <b>#{record.start_time.hour}</b> часов"
    UserPolicy.new(master_login).all_rights? ? client_info = "Клиент: <b>#{record.client_name} - #{record.client_phone}</b>" : client_info = "Клиент: <b>#{record.client_name}</b>"

    if !record.record_services.empty?
      record.record_services.all.each do |record_service|
        service_text += "<b>#{Service.find_by(id: record_service.service_id).name};</b>"
      end
    end

    if !record.record_purchases.empty?
      record.record_purchases.all.each do |record_purchase|
        purchase_text += "<b>#{Purchase.find_by(id: record_purchase.purchase_id).name};</b>"
      end
    end

    text = "<i>#{notice}:</i>
    #{date_text}
    #{master_text}
    #{record_text}
    #{client_info}
    Услуги: #{service_text}
    Покупки: #{purchase_text}"

    bot = Telegram::Bot::Client.new(token)

    chat_ids.each do |chat_id|
      bot.api.sendMessage(parse_mode: 'HTML', chat_id: chat_id, text: text) if !chat_id.nil?
    end
  end
end