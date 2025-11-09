class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_candidate_spot

  def create
    @candidate_spot.votes.find_or_create_by(user: current_user)
    redirect_to group_path(@candidate_spot.group), notice: "「#{@candidate_spot.spot.name}」に投票しました。"
  end

  def destroy
    vote = @candidate_spot.votes.find(params[:id])
    vote&.destroy
    redirect_to group_path(@candidate_spot.group), notice: "「#{@candidate_spot.spot.name}」への投票を取り消しました。"
  end

  private

  def set_candidate_spot
    # ユーザーが所属するグループの候補地であることを確認するとより安全
    @candidate_spot = CandidateSpot.find(params[:candidate_spot_id])
    # TODO: ユーザーがこのグループのメンバーであるかどうかのチェックを追加するとより安全
  end
end