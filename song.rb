require "json"

# rubocop:disable Style/ClassVars
class Song
  attr_reader :id, :songs

  @@id_count = 0

  def initialize(title:, artists:, album:, released:, id: nil)
    # @id = id ? id : @@id_count.next
    @id = id || @@id_count.next
    @@id_count = @id
    @title = title
    @artists = artists
    @album = album
    @released = released.to_i
  end

  def details
    [@id, @title, @artists.join(", "), @album, @released]
  end

  def to_json(_generator)
    { id: @id, title: @title, artists: @artists, album: @album, released: @released }.to_json
  end

  def update(title:, artists:, album:, released:)
    @title = title unless title.empty?
    @artists = artists unless artists.empty?
    @album = album unless album.empty?
    @released = released.to_i unless released.empty?
  end
end
# rubocop:enable Style/ClassVars
