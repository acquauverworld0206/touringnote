class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    # ユーザーがグループのメンバーであるかを確認
    unless @group.users.include?(current_user)
      redirect_to groups_path, alert: "あなたはこのグループのメンバーではありません。"
      return
    end

    @message = @group.messages.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_to group_path(@group), notice: "メッセージを送信しました。"
    else
      # メッセージの保存に失敗した場合、アラートを表示してリダイレクト
      redirect_to group_path(@group), alert: "メッセージの送信に失敗しました。内容を入力してください。"
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
