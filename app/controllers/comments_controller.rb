# frozen_string_literal: true

# Application Controller.
class CommentsController < ApplicationController
  #
  ## creating new comments
  #
  before_action :set_note, only: %i[new create edit update destroy]

  def new
    @comment = Comment.new
    # @note = Note.find(params[:note_id])
  end

  def create
    # @note = Note.find(params[:note_id])
    @comment = @note.comments.create(comment_params)
    respond_to do |format|
      format.js {}
    end
  end

  #
  ## deleting notes
  #

  def destroy
    # @note = Note.find(params[:note_id])
    @comment = @note.comments.find(params[:id])
    @comment.destroy
    redirect_to notes_path(@note)
  end

  #
  ## editing notes
  #

  def edit
    # @note = Note.find(params[:note_id])
    @comment = @note.comments.find(params[:id])
    # redirect_to notes_path(@note)
  end

  def update
    # @comments = Comment.all
    # @note = Note.find(params[:note_id])
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
  end

  #
  ## parameters
  #

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id)
  end

  def set_note
    @note = Note.find_by(id: params[:note_id])
  end
end
