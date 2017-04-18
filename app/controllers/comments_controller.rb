class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params.merge(event: Event.find(comment_params[:event]), user: User.find(session[:user_id])))
    if not comment.save
      flash[:errors] = comment.errors.full_messages
    end
    redirect_to "/events/#{comment_params[:event]}"      # "events/#{event.id}"
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :event)
    end
end
