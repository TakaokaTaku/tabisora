class MemosController < ApplicationController
  before_action :correct_user,   only: [:destroy]

  def new
    @memo = current_user.memos.build
    @memos = current_user.memos.paginate(page: params[:page])
  end

  def create
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      flash[:success] = "メモを追加しました"
      redirect_to new_memo_path
    else
      flash[:danger] = "メモの内容を記入してください"
      redirect_to new_memo_path
    end
  end

  def destroy
    Memo.find(params[:id]).destroy
    flash[:success] = "メモを消去しました"
    redirect_to new_memo_path
  end

  private

  def memo_params
    params.require(:memo).permit(:content)
  end

  def correct_user
    @memo = current_user.memos.find(params[:id])
    redirect_to root_url if @memo.nil?
  end
end
