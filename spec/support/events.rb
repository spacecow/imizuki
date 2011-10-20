def create_pic(file,event)
  Picture.create!(:image => File.open("spec/#{file}"), :event_id => event.id)
end
