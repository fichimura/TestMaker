class StaticPagesController < ApplicationController

    skip_before_action :authenticate_user!, :only => [:landing_page]
    
    def landing_page
        @courses = Course.all.limit(3)
        @latest_couses = Course.all.limit(3).order(created_at: :desc)
    end

    def index
        @courses = Course.all.limit(3)
        @latest_good_reviews = Enrollment.reviewed.latest_good_reviews
        @latest = Course.latest
        @top_rated = Course.top_rated
        @popular = Course.popular
    end

    def activity
        @activities = PublicActivity::Activity.all
        if current_user.has_role?(:admin)
          @activities = PublicActivity::Activity.all
        else
          redirect_to root_path, alert: "Você não pode acessar esta página"
        end
      end
    
      def analytics
        if current_user.has_role?(:admin) || current_user.has_role?(:professor)
          @users = User.all
          @enrollments = Enrollment.all
          @courses = Course.all
        else
          redirect_to root_path, alert: "Você não pode acessar esta página"
        end
      end
  
end