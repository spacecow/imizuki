module ApplicationHelper
  def create(s); lbl(:create,s) end
  def lbl(s,o); t("label.#{s}",:obj=>t(o)) end
  def messages(s); t("messages.#{s}") end
  def sure?; messages(:sure?) end
end
