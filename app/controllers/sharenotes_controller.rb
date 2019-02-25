class SharenotesController < ApplicationController
  before_action :authenticate_user!
  def index
    @sharenotes = Sharenote.select("*").joins(:note).where(email: current_user.email).where(notes: {status: false})
  end

  def shownote
    @sharednotes = Sharenote.select("*").joins(:note).where(user_id: current_user.id).where(notes: {status: false})
  end

  def new
    @sharenote = Sharenote.new
    @note = Note.find(params[:note_id])
  end

  def create
    @note = Note.find(params[:note_id])
    @user = current_user.email
    @shemail= params[:sharenote][:email]
    @sharenote = @note.sharenotes.create(sharenote_params)

    if User.where(:email => params[:sharenote][:email]).present?
      NoteMailer.share_email(@sharenote,@user).deliver
    else
      NoteMailer.reg_email(@sharenote,@user).deliver
    end
    redirect_to notes_path
  end

  def editaccess
    @note = Note.find(params[:id])
    #render plain: @note.inspect
    #return
    @user = current_user.email
    @sendto = User.find(@note.user_id).email
    NoteMailer.edit_email(@sendto,@user,@note).deliver
    #redirect_to notes_path
  end

  def updatepermission
    @note = Note.find(params[:id])
    @sharenote = Sharenote.where(note_id: @note )
    #render plain: @sharenote.inspect
    @sharenote.update(edit: true)
    redirect_to notes_path  
  end

  private
  def sharenote_params
    params.require(:sharenote).permit(:email, :user_id, :edit, :view)
  end
end
