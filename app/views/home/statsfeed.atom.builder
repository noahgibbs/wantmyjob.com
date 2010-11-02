atom_feed do |feed|
  feed.title "WantMyJob Stats"
  feed.updated @notes[0].updated_at

  @notes.each do |note|
    feed.entry do |entry|
      entry.title note.title
      entry.updated note.updated_at
      entry.content note.body
      entry.author { |author| author.name("WantMyJob Admin") }
    end
  end
end
