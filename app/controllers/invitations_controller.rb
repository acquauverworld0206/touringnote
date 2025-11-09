class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:create] # 作成時のみグループIDが必要
  before_action :set_invitation, only: [:accept, :reject]

  def index
    # 自分宛ての、まだ保留中(pending)の招待を取得
    @pending_invitations = current_user.received_invitations.where(status: 'pending')
  end
  def create
    # 招待する権限があるか確認（ここではグループのホストのみとします）
    unless @group.host == current_user
      redirect_to group_path(@group), alert: "招待する権限がありません。"
      return
    end

    recipient = User.find_by(email: params[:email])

    if recipient
      @invitation = @group.invitations.new(sender: current_user, recipient: recipient)
      if @invitation.save
        redirect_to group_path(@group), notice: "#{recipient.nickname}さんをグループに招待しました。"
      else
        redirect_to group_path(@group), alert: "招待に失敗しました。#{@invitation.errors.full_messages.join(', ')}"
      end
    else
      redirect_to group_path(@group), alert: "入力されたメールアドレスのユーザーは見つかりませんでした。"
    end
  end

  def accept
    # 招待された本人か確認
    if @invitation.recipient == current_user
      # ユーザーをグループメンバーに追加
      @invitation.group.group_members.create(user: current_user, role: 'member')
      # 招待のステータスを更新
      @invitation.update(status: 'accepted')
      redirect_to group_path(@invitation.group), notice: "「#{@invitation.group.name}」に参加しました。"
    else
      redirect_to invitations_path, alert: "不正な操作です。"
    end
  end

  def reject
    @invitation.update(status: 'rejected')
    redirect_to invitations_path, notice: "招待を拒否しました。"
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end
end
