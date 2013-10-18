class AddDataPointWorker
  include Sidekiq::Worker

  def perform(data)
    @data_point = DataReading.new(red: data["red"], green: data["green"], blue: data["blue"], white: data["white"]).save
  end
end
