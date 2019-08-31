class TweetsController < ApplicationController
    
    def index
        @tweets = Tweet.all
      end
    
      def new
      end
    
      def create
        Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
      end
    
      def destroy
        tweet = Tweet.find(params[:id])
        tweet.destroy if tweet.user_id == current_user.id
      end
    
      def show
        @tweet = Tweet.find(params[:id])
        @comments = @tweet.comments.includes(:user)
      end
      
      private
      def tweet_params
          params.permit(:text)
      end

      def move_to_index
         redirect_to action: :index unless user_signed_in?
      end

end
