module ApplicationHelper
  def create(s); lbl(:create,s) end
  def either_of(b,s1,s2); b ? s1 : s2 end
  def lbl(s,o); t("label.#{s}",:obj=>t(o)) end
  def messages(s); t("messages.#{s}") end
  def sure?; messages(:sure?) end
  def update(s); lbl(:update,s) end
end
