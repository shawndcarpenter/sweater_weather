class UserFinderJob < ApplicationJob
  queue_as :default

  def perform(user_email)
    user = User.find_by(email: user_email)
  end
end
