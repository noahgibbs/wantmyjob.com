class NotesController < ApplicationController
  def index
    @notes = Note.daily_feed

    respond_to do |format|
      format.atom { render :layout => false }
      format.html { }
    end
  end
end
