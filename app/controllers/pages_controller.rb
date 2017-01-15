class PagesController < ApplicationController

  layout "layouts/admin_layout"

  def home

    @request = Request.new

    @values = CompanyValue.all

    @current_nav_identifier = :home
    @minions = User.where(["manager_id=?",current_user.id])

    @minions_details = Array.new
    @minions.each do |minion|
      @minions_details << [minion.email,minion.id,0,0,minion.givenname,minion.sn]
      puts "** #{[minion.email,minion.id,0,0]}"
    end

    #extracting ids to an array
    minion_ids = []
    @minions_details.each do |detail|
     minion_ids << detail[1]
    end
    #
    # Regulating request options
    #

    @training_categories = TrainingCategory.all


    @categories = Array.new
    @training_categories.each do |category|
      @categories << category.category
    end



    @request_options = @categories
    @request_categories = Request.where(user_id:current_user.id)
    requested_array = []
    @request_categories.each do |cat|
      requested_array << cat.category
    end
    puts "************* requested_array:"
    puts requested_array
    puts "*************"
    @request_options_minus = @request_options - requested_array
    #
    # Loop to count how many times each request appears in the database
    #

    @minions_requests = Request.where(user_id:minion_ids)
    @category_counts = []
    @minions_requests.each do |request|

     # puts " start of request:  #{request.category}  loop"

      found = false
      @category_counts.each do |cat_count|
        if cat_count[0] == request.category
          cat_count[1] += 1
          found = true;
          break;
        end
      end

      if found == false
       #"FAILED TO FIND CATEGORY IN ARRAY, ADDING NEW "
        @category_counts << [request.category,1]
      end
    end# end of request loop

    #@hash1 = Hash.new("value" => @category_counts[0][1], "label" => @category_counts[0][0],"color" => "#7955A3","highlight"=>"#FF5A5E")


    # puts @minions_details
    @minions_objectives = Objective.where(user_id:minion_ids)

    @minions_objectives.each do |objective|
      @minions_details.each do |user|
        if objective.user_id == user[1]
          if objective.status == 1
            if objective.completed?
              user[2]+=1
            else
              user[3]+=1
            end
          end
        end
      end
    end
    #loop ends

    #finding top manager, with no managers above them
    if current_user.manager?
      if not(current_user.manager_id)
        @top_boss = true
      end
    end

  end #end of Home function

end
