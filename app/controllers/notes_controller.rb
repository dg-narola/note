class NotesController < ApplicationController
  before_action :authenticate_user!
  def index
    #@notes = Note.all
    #@notes = Note.find(:all, :conditions => { :status => false })
    @n = Note.where(user_id: current_user.id,status: false)
    @notes = Note.where(user_id: current_user.id,status: false).all.order("created_at DESC")

    #@note = Note.find_by_id(params[:id])
  end

  def create
    @notes = Note.all
    @note = Note.create(note_params)
    redirect_to notes_path
  end
  def show
    @note = Note.find(params[:id])
    @comments = @note.comments.paginate(:page => params[:page], :per_page => 10) 
  end

  def new
    @note = Note.new
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @notes = Note.all
    @note = Note.find(params[:id])
    @note.update(note_params)
    redirect_to notes_path
  end

  def delete
    @note = Note.find(params[:note_id])
  end

  def destroy
    @notes = Note.all
    @note = Note.find(params[:id])
    @note.update_attributes(status: true)
    redirect_to notes_path
    #@note.destroy
  end
  private

  def note_params
    params.require(:note).permit(:title, :description, :user_id)
  end
end
