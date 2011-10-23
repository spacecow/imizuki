def create_pic(file,event)
  Picture.create!(:image => File.open("spec/#{file}"), :event_id => event.id)
end
def create_picture(file,event); create_pic(file,event) end
