class SpotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot, only: [:show, :edit, :update, :destroy]

  def index
    @spots = current_user.spots.order(created_at: :desc)
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = current_user.spots.build(spot_params)
    if @spot.save
      redirect_to spots_path, notice: "スポットを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @spotはbefore_actionでセットされます
  end

  def edit
    # @spotはbefore_actionでセットされます
  end

  def update
    if @spot.update(spot_params)
      redirect_to spots_path, notice: "スポットを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @spot.destroy
    redirect_to spots_path, notice: "スポットを削除しました。", status: :see_other
  end

  def random_draw
    # 自分のスポットリストを取得
    my_spots = current_user.spots

    # スポットが1つもない場合は、マイスポット一覧ページに戻ってメッセージを表示
    if my_spots.empty?
      redirect_to spots_path, alert: "抽選するスポットがありません。先にスポットを登録してください。"
      return
    end

    # スポットリストからランダムに1つ抽選
    @selected_spot = my_spots.sample
    # 結果表示ページへ
    render :random_draw
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :description, :address, :photo, :tags)
  end

  def set_spot
    # showアクションの場合は、どのユーザーでもスポットを閲覧できるようにする
    if action_name == 'show'
      @spot = Spot.find(params[:id])
    else
      @spot = current_user.spots.find(params[:id])
    end
  end
end
