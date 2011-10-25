def create_pic(file,event,caption=nil)
  Picture.create!(:image => File.open("spec/#{file}"), :event_id => event.id, :caption => caption)
end
def create_picture(file,event); create_pic(file,event) end
