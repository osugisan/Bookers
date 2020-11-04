class RelationshipsController < ApplicationController

  def create
    current_user.active_relationships.create(followed_id: params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.active_relationships.find_by(followed_id: params[:user_id]).destroy
    redirect_to request.referer
  end
end

