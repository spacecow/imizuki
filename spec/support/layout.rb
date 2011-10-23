def have_image(alt)
  have_xpath("//img[@alt='#{alt}']")
end

def have_link(txt)
  have_css("a", :text => txt)
end

def div(id)
  find(:css, "div##{id}")
end
