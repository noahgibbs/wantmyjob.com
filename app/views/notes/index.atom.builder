atom_feed do |feed|
  feed.title "WantMyJob Stats"
  feed.updated @notes[0].updated_at

  @notes.each do |note|
    feed.entry(note) do |entry|
      entry.title note.title
      entry.content note.body
      entry.url "http://wantmyjob.com/statsfeed#note_#{note.id}"
      entry.author { |author| author.name("WantMyJob Admin") }
    end
  end
end
