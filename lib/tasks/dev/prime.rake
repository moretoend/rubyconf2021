unless Rails.env.production?
  require "faker"

  namespace :dev do
    desc "Sample data for local development environment"
    task prime: ['db:drop', 'db:setup'] do
      users_to_insert = 50.times.map do
        { name: Faker::Name.unique.name, email: Faker::Internet.unique.email }
      end
      User.insert_all(users_to_insert)

      Streamer.insert_all([
        { name: "PokemaoBR" }, { name: "PachiCodes" }, { name: "TonhoCodes" },
        { name: "Perifericah" }, { name: "Leitoraincomum" }
      ])
      
      streamer_ids = Streamer.pluck(:id)
      lives_to_insert = 20.times.map do |index|
        streamer_ids.map do |streamer_id|
          live_duration = 3.upto(10).to_a.sample
          live_start_date = (100 / 5 - index).days.ago
          live_end_date = live_start_date + live_duration.hours
          { start_date: live_start_date, end_date: live_end_date, streamer_id: streamer_id }
        end
      end.flatten

      Live.insert_all(lives_to_insert)

      user_ids = User.pluck(:id)
      live_ids = Live.pluck(:id)
      messages_to_insert = 50000.times.map do |index|
        seconds_ago = (50000 - index).seconds.ago
        user_id = user_ids.sample
        live_id = live_ids.sample
        { body: Faker::Lorem.sentence, send_date: seconds_ago, user_id: user_id, live_id: live_id }
      end

      Message.insert_all(messages_to_insert)

      user_ids = User.pluck(:id)
      lives = Live.pluck(:id, :start_date, :end_date)
      watchings_to_insert = 50.times.map do |index|
        user_id = user_ids[index]
        lives.sample(35).map do |live|
          live_duration = (live.third - live.second).to_i
          watching_duration = rand(240..live_duration) 
          { duration_in_seconds: watching_duration, user_id: user_id, live_id: live.first }
        end
      end.flatten

      Watching.insert_all(watchings_to_insert)

      user_ids = User.pluck(:id)
      streamer_ids = Streamer.pluck(:id)
      subs_to_insert = streamer_ids.each.map do |streamer_id|
        rand(30..40).times.map do |index|
          { streamer_id: streamer_id, user_id: user_ids[index], tier: :bronze }
        end
      end.flatten

      Subscription.insert_all(subs_to_insert)
    end
  end
end