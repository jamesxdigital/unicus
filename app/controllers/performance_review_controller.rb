class PerformanceReviewController < ApplicationController

	def index
		if current_user.manager?
        @minions = User.where(["manager_id=?",current_user.id])

        @minion_ids = Array.new # hold minion info
        minionids = Array.new # holds minion ID's only
        @manager_objectives = Array.new
        #minion_emails = Array.new

        if @minions.count > 0
          @minions.each do |minion|
            @minion_ids << [minion.email,minion.id,minion.givenname,minion.sn]
            minionids << minion.id
          end
          @manager_objectives = Objective.where(user_id:minionids).where(status: 1)
        end
      end
	end
end
