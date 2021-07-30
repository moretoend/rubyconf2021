ENV['RAILS_ENV'] = 'development'
require_relative '../config/environment.rb'


#### FASE 01 ####

# 1. Quantas mensagens foram enviadas numa Live?

# ap Live.first.messages.count



# 2. Media de tempo que as pessoas assistiram uma Live?

# ap Live.first.watchings.average(:duration_in_seconds).to_i



# 3. E estes dois para cada live?

# ap Watching.joins(live: :streamer)
#            .group("lives.id")
#            .count

# ap Message.joins(live: :streamer)
#           .group("lives.id")
#           .count

# ap Live.joins(:streamer, :watchings)
#        .group("lives.id, streamers.name")
#        .select("lives.id, streamers.name, COUNT(watchings.id) AS count")
#        .all

# watching = Watching.arel_table

# ap Live.joins(:streamer, :watchings)
#        .group("lives.id, streamers.name")
#        .select("lives.id, streamers.name", watching[:id].count.as('count'))
#        .all



# 4. Quais Streamers começam com a letra “P”

# streamer = Streamer.arel_table

# ap Streamer.where(streamer[:name].matches('p%'))





#### FASE 02 ####

# 1. Quantas mensagens cada streamer teve em sua última live?

# live = Live.arel_table
# streamer = Streamer.arel_table
# message = Message.arel_table

# streamer_last_lives = live.project(:streamer_id, live[:start_date].maximum.as('date'))
#                           .group(:streamer_id)
#                           .as('streamer_last_lives')

# last_streamer_live = Live.joins(:streamer, :messages)
#                          .joins(
#                            live.join(streamer_last_lives)
#                              .on(
#                                live[:streamer_id].eq(
#                                  streamer_last_lives[:streamer_id]).and(
#                                    live[:start_date].eq(streamer_last_lives[:date])
#                                  )
#                                )
#                              .join_sources
#                            )
#                            .group(live[:id], streamer[:name])
#                            .select(live[:id], streamer[:name], message[:id].count)

# ap last_streamer_live


# 2. Qual foi a média de horas de pessoas assistindo a última live de cada streamer?

# live = Live.arel_table
# streamer = Streamer.arel_table
# watching = Watching.arel_table

# streamer_last_lives = live.project(:streamer_id, live[:start_date].maximum.as('date'))
# 						  .group(:streamer_id)
# 						  .as('streamer_last_lives')

# last_streamer_live = Live.joins(:streamer, :watchings)
#                          .joins(
#                            live.join(streamer_last_lives)
#                                .on(
#                                   live[:streamer_id].eq(
#                                     streamer_last_lives[:streamer_id]).and(
#                                       live[:start_date].eq(streamer_last_lives[:date]
#                                     )
#                                   )
#                                 )
#                                .join_sources
#                          )
#                          .group(live[:id], streamer[:name])
#                          .select(live[:id], streamer[:name], watching[:id].average)

# ap last_streamer_live



# 3. Quantos inscritos cada streamer teve interagindo em suas lives 
#    (considerando que “interagir” é enviar mais de 20 mensagens)

# live = Live.arel_table
# user = User.arel_table
# subscription = Subscription.arel_table
# message = Message.arel_table
# streamer = Streamer.arel_table

# subs_with_interaction = user.join(message).on(user[:id].eq(message[:user_id]))
#                             .join(subscription).on(user[:id].eq(subscription[:user_id]))
#                             .project(
#                              	user[:id], 
#                              	subscription[:streamer_id].as('streamer_id'), 
#                              	message[:live_id])
#                             .group(
#                             	user[:id], 
#                              	subscription[:streamer_id], 
#                             	message[:live_id])
#                             .having(message[:id].count.gt(20))
#                             .as('user_interaction')

# streamers_with_interaction = Streamer.joins(:lives)
#                                      .joins(
#                                        live.join(subs_with_interaction)
#                                            .on(
#                                              live[:id].eq(
#                                                subs_with_interaction[:live_id])
#                                               .and(
#                                                 streamer[:id].eq(
#                                                   subs_with_interaction[:streamer_id]
#                                                 )
#                                               )
#                                             )
#                                            .join_sources
#                                      )
#                                      .group("streamers.name", live[:id])
#                                      .select(
#                                         streamer[:name], 
#                                         streamer[:id].as("streamer_id"), 
#                                         live[:id], 
#                                         subs_with_interaction[:id].count
#                                      )

# ap streamers_with_interaction

# ap User.joins(:subscriptions, :messages).where(subscriptions: { streamer_id: 2 }, messages: { live_id: 82 }).group("users.id").count