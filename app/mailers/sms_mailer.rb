require "net/http"
require "addressable/uri"

class SmsMailer
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def send_sms
    work_day_flag = WorkDay.find_by id: record.work_day_id
    day_flag = Day.find_by id: work_day_flag.day_id
    month_flag = Month.find_by id: day_flag.month_id
    salon_flag = Salon.find_by id: work_day_flag.salon_id
    master_flag = Master.find_by id: work_day_flag.master_id

    month_number = month_flag.number.to_s

    if month_number.length == 1
      month_number = "0" + month_number
    end

    day_number = day_flag.number_of_the_day.to_s

    if day_number.length == 1
      day_number = "0" + day_number
    end

    hour_start = record.start_time.hour.to_s

    if hour_start.length == 1
      hour_start = "0" + hour_start
    end

    notice_sms = "Успешная запись Адрес:#{salon_flag.address} Дата:#{day_number}.#{month_number}, в #{record.start_time.hour} Мастер:#{master_flag.name}"
    url = "http://api.prostor-sms.ru/messages/v2/send/?login=t89534074294&password=480577&phone=+#{parse_phone}&text=#{notice_sms}"

    uri = Addressable::URI.parse(url)

    response = Net::HTTP.get_response(uri.normalize)
  end

  def parse_phone
    phone = record.client_phone

    phone[0] = "7"

    return phone
  end
end