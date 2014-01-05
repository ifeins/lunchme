class VoteObserver < ActiveRecord::Observer
  observe :vote

  def after_create(vote)
    notify_vote(vote)
  end

  private

  def notify_vote(vote)
    Pusher.trigger(pusher_channel(vote), 'restaurant-voted', message: VoteSerializer.new(vote).to_json)
  end

  def pusher_channel(vote)
    "lunch-#{vote.lunch.id}"
  end

end