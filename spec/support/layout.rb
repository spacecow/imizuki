def have_image(alt)
  have_xpath("//img[@alt='#{alt}']")
end

def have_link(txt)
  have_css("a", :text => txt)
end
