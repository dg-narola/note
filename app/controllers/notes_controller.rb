class NotesController < ApplicationController
  before_action :authenticate_user!

  #
  ##show all notes
  #

  def index
    @n = Note.where(user_id: current_user.id,status: false)
    @notes = Note.where(user_id: current_user.id,status: false
    ).all.order("created_at DESC")
  end

    #
    ##searching
    #

  def search
    #tag = params[:search_notes][:query]
    query = params[:search_notes].presence && params[:search_notes][:query]
    tags = Note.tagged_with(query)
    note = Note.search_published(query)
    if query
      @notes = tags + note
    end
  end

    #
    ##creating new notes
    #

  def new
      @note = Note.new
  end

  def create
    @notes = Note.all
    @note = Note.create(note_params)
    respond_to do |format|
      format.js { render js: 'window.location.href = "notes";' }
    end
  end

    #
    ##show all notes and comments with pagination
    #

  def show
    @note = Note.find(params[:id])
    @related_notes = @note.find_related_tags
    @comments = @note.comments.paginate(:page => params[:page], :per_page => 10)
  end

    #
    ##to mark note as important
    #

  def important
    @note = Note.find(params[:id])
    @note.update_attributes(important: true)
    redirect_to notes_path
  end

    #
    ##to mark note as unimportant
    #

  def unimportant
    @note = Note.find(params[:id])
    @note.update_attributes(important: false)
    redirect_to notes_path
  end

    #
    ##tags
    #

  def tagged
    if params[:tag].present?
      @notes = Note.tagged_with(params[:tag])
    else
      @notes = Note.all
    end
  end

    #
    ##To enable autosave
    #

  def autosave
    @user = User.find(current_user.id)
    @user.update_attributes(autosave: true)
    respond_to do |format|
      format.js { render js: 'window.location.href = "notes";' }
    end
  end

    #
    ##to disable autosave
    #

  def noautosave
    @user = User.find(current_user.id)
    @user.update_attributes(autosave: false)
    respond_to do |format|
      format.js { render js: 'window.location.href = "notes";' }
    end
  end

    #
    ##editing the notes
    #

  def edit
    @note = Note.find(params[:id])
    respond_to do |format|
      format.html { render :edit }
      format.js
      format.json { render json: @note}
    end
  end

    #
    ##updating the notes
    #

  def update
    @notes = Note.all
    @note = Note.find(params[:id])
    @note.update_attributes(note_params)
    respond_to do |format|
      format.js { render js: 'window.location.href = "notes";' }
    end
  end

    #
    ##getting notes id for performind delete
    #

  def delete
    @note = Note.find(params[:id])
    #render plain: @note.inspect
  end

    #
    ##for destroying the notes
    #

  def destroy
    @notes = Note.all
    @note = Note.find(params[:id])
    @note.update_attributes(status: true)
    redirect_to notes_path
  end

    #
    ##parameters
    #

  private

  def note_params
    params.require(:note).permit(
      :title,
      :description,
      :user_id,
      :tag_list
    )
  end
end
