class VoteObserver < ActiveRecord::Observer
  observe :vote

  def after_create(vote)
    notify_vote_event('restaurant-voted', vote)
  end

  def after_destroy(vote)
    notify_vote_event('restaurant-unvoted', vote)
  end

  private

  def notify_vote_event(event_name, vote)
    Pusher.trigger(pusher_channel(vote), event_name, vote_json: VoteSerializer.new(vote).to_json)
  end

  def pusher_channel(vote)
    "lunch-#{vote.lunch.id}"
  end

end