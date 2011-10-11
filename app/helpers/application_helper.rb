module ApplicationHelper
  def create(s); labels(:create,s) end
  def either_of(b,s1,s2); b ? s1 : s2 end
  def labels(s,o); t("labels.#{s}",:obj=>t(o)) end
  def messages(s); t("messages.#{s}") end
  def sure?; messages(:sure?) end
  def update(s); labels(:update,s) end
end
