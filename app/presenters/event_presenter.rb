class EventPresenter < BasePresenter
  presents :event

  def edit_action
    h.link_to h.jt(:edit), h.edit_event_path(event) if h.can? :edit, event
  end

  def destroy_action
    h.link_to h.jt(:del), event, confirm:h.sure?, :method => :delete if h.can? :destroy, event
  end
end
