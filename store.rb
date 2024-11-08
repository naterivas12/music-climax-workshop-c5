require "json"
require_relative "playlist"

class Store
  attr_reader :playlists

  def initialize(filename)
    @filename = filename
    @playlists = load_playlist
  end

  def add_playlist(playlist)
    @playlists.push(playlist)
    save
  end

  def update_playlist(id, data)
    playlist = find_playlist(id)
    playlist.update(data)
    save
  end

  def delete_playlist(id)
    playlist = find_playlist(id)
    @playlists.delete(playlist)
    save
  end

  def find_playlist(id)
    @playlists.find { |pl| pl.id == id }
  end

  def add_song(new_song, id)
    playlist = find_playlist(id)
    playlist.songs.push(new_song)
    save
  end

  def update_song(id, new_data, playlist_id)
    playlist = find_playlist(playlist_id)
    song = find_song(id, playlist)
    song.update(new_data)
    save
  end

  def delete_song(id, playlist_id)
    playlist = find_playlist(playlist_id)
    playlist.songs.delete_if { |song| song.id == id }
    save
  end

  def find_song(id, playlist)
    playlist.songs.find { |song| song.id == id }
  end

  private

  def load_playlist
    data = JSON.parse(File.read(@filename), { symbolize_names: true })
    data.map do |playlist_data|
      Playlist.new(playlist_data)
    end
  end

  def save
    File.write(@filename, @playlists.to_json)
  end
end
