class SharenotesController < ApplicationController
  before_action :authenticate_user!

    #
    ##to get the notes shared to a particular use
    #

  def index
    #@sharenotes = Sharenote.all.joins(:note).where(email: current_user.email).where(notes: {status: false})
    @sharenotes = Sharenote.all.includes(:note).where(
      email: current_user.email).where(notes: {status: false})
    #render plain: @sharenotes.inspect
  end

    #
    ##to get the notes shared by a particular use
    #

  def shownote
    #@sharednotes = Sharenote.all.includes(:note).where(user_id: current_user.id).where(notes: {status: false})
    @sharednotes = Sharenote.all.joins(:note).where(
      user_id: current_user.id).where(notes: {status: false})
  end

    #
    ##to send email for sharing notes
    #

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

    #
    ##to send email to a user for edit permission
    #

  def editaccess
    @note = Note.find(params[:id])
    #render plain: @note.inspect
    #return
    @user = current_user.email
    @sendto = User.find(@note.user_id).email
    NoteMailer.edit_email(@sendto,@user,@note).deliver
    #redirect_to notes_path
  end

    #
    ##to update the edit permission in database
    #

  def updatepermission
    @note = Note.find(params[:id])
    #@sharenotes = @note.sharenotes.where(note_id: @note)
    @sharenote = Sharenote.where(id: @note )
    @sharenote.update(edit: true)
    #render plain: @sharenote.inspect
    redirect_to notes_path
  end

    #
    ##parameters
    #

  private
  def sharenote_params
    params.require(:sharenote).permit(:email, :user_id, :edit, :view)
  end
end
