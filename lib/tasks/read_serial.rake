require "serialport"
namespace :fetch do
  desc "Read data coming in from the arduino serial port"
  task data: :environment do
    sp = SerialPort.new(ENV['PORT'],ENV['BAUD_RATE'].to_i, ENV['DATA_BITS'].to_i, ENV['STOP_BITS'].to_i, SerialPort::NONE)
    while true do
      data_buffer = ""
      data = Hash.new
      data_array = Array.new
      while(raw_data = sp.getc.chomp) do
        if raw_data == ';'
          data_array = data_buffer.split(",")
          data[data_array[0]] = data_array[1]
          data_buffer = ""
          if data["red"].present? && data["green"].present? && data["blue"].present? && data["white"].present?
            puts data
            AddDataPointWorker.perform_async(data)
            data = Hash.new
          end
        elsif raw_data == "\n"

        else
          data_buffer << raw_data
        end
        raw_data = ''
      end
    end
    sp.close
  end
end
