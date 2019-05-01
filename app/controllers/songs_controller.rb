class SongsController < ApplicationController
  before_action :find_song, except: %i[index new create]

  def index
    @songs = Song.all
  end

  def show; end

  def new
    @song = Song.new
  end

  def edit; end

  def create
    @song = Song.new(song_params)
    if @song.save
      flash[:success] = 'Song successfully created'
      redirect_to @song
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    if @song.update_attributes(song_params)
      flash[:success] = 'Song was successfully updated'
      redirect_to @song
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    if @song.destroy
      flash[:success] = 'Song was successfully deleted'
      redirect_to songs_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to songs_path
    end
  end

  private

  def find_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :released, :release_year, :artist_name, :genre)
  end
end
