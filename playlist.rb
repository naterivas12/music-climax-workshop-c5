require "json"
require_relative "song"

# rubocop:disable Style/ClassVars
class Playlist
  attr_reader :id, :name, :songs

  @@id_count = 0
  # {id: 1, name: "List name", description: "Desc", songs: [...]}
  def initialize(name:, description:, id: nil, songs: [])
    # @id = id ? id : @@id_count.next
    @id = id || @@id_count.next
    @@id_count = @id # luego de cargar un nuevo playlist sin ID, @@id_count pasa a ser 3
    @name = name
    @description = description
    @songs = songs.map { |song_data| Song.new(song_data) } # [{...}, {...}] => [Song1, Song2]
  end

  def details
    [@id, @name, @description, "#{@songs.size} Songs"]
  end

  def to_json(_generator)
    { id: @id, name: @name, description: @description, songs: @songs }.to_json
  end

  def update(name:, description:)
    @name = name unless name.empty?
    @description = description unless description.empty?
  end
end
# rubocop:enable Style/ClassVars
