def error_field
  find(:css, "li#event_title_input p.inline-errors")
end

def fieldsets(klass,scope = {})
  return all(:xpath, "#{scope[:within].path}/ol/li/fieldset[@class='#{klass}']") unless scope.empty?
  all(:xpath, "//fieldset[@class='#{klass}']")
end

def fieldset(klass,no,scope={}); fieldsets(klass,scope)[no] end

def radio(scope = {})
  find(:xpath, "#{fieldset("choices", 0, scope).path}/ol/li/label/input")
end
