# frozen_string_literal: true

# Application Controller.
class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: %i[show edit update delete destroy important unimportant]

  #
  ## show all notes
  #

  def index
    # @n = Note.where(user_id: current_user.id, status: false).all
    @notes = Note.includes(:taggings).where(
      user_id: current_user.id, status: false
    ).order('created_at DESC')
    # @notes = Note.where(
    #  user_id: current_user.id, status: false
    # ).all.order('created_at DESC')
  end

  #
  ## searching
  #

  def search
    # tag = params[:search_notes][:query]
    query = params[:search_notes].presence && params[:search_notes][:query]
    tags = Note.tagged_with(query)
    note = Note.search_published(query)
     # render plain: note.inspect
    return unless query

    @notes =  tags + note
    # render plain: @notes.inspect
  end

  #
  ## creating new notes
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
  ## show all notes and comments with pagination
  #

  def show
    # @note = Note.find_by_id(params[:id])
    @related_notes = @note.find_related_tags
    @comments = @note.comments.paginate(page: params[:page], per_page: 10)
  end

  #
  ## to mark note as important
  #

  def important
    # @note = Note.find_by_id(params[:id])
    @note.update(important: true)
    redirect_to notes_path
  end

  #
  ## to mark note as unimportant
  #

  def unimportant
    # @note = Note.find_by_id(params[:id])
    @note.update(important: false)
    redirect_to notes_path
  end

  #
  ## tags
  #

  def tagged
    tag = params[:tag]
    if tag.present?
      @notes = Note.includes(:taggings).tagged_with(tag)
      _b = 1
    else
      @notes = Note.all
      _b = 2
    end
  end

  #
  ## To enable autosave
  #

  def autosave
    @user = User.find_by(id: current_user.id)
    @user.update(autosave: true)
    respond_to do |format|
      format.js { render js: 'window.location.href = "notes";' }
    end
  end

  #
  ## to disable autosave
  #

  def noautosave
    @user = User.find_by(id: current_user.id)
    @user.update(autosave: false)
    respond_to do |format|
      format.js { render js: 'window.location.href = "notes";' }
    end
  end

  #
  ## editing the notes
  #

  def edit
    # @note = Note.find_by_id(params[:id])
    respond_to do |format|
      format.html { render :edit }
      format.js
      format.json { render json: @note }
    end
  end

  #
  ## updating the notes
  #

  def update
    @notes = Note.includes(:tag).all
    # @note = Note.find_by_id(params[:id])
    @note.update(note_params)
    respond_to do |format|
      format.js { render js: 'window.location.href = "notes";' }
    end
  end

  #
  ## getting notes id for performind delete
  #

  def delete
    # @note = Note.find_by_id(params[:id])
    # render plain: @note.inspect
  end

  #
  ## for destroying the notes
  #

  def destroy
    @notes = Note.all
    # @note = Note.find_by_id(params[:id])
    @note.update(status: true)
    redirect_to notes_path
  end

  #
  ## parameters
  #

  private

  def note_params
    params.require(:note).permit(
      :title,
      :description,
      :user_id,
      :tag_list,
      :price
    )
  end

  def set_note
    @note = Note.find_by(id: params[:id])
  end
end
