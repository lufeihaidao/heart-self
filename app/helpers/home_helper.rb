module HomeHelper
  def active?(action_name)
    self.action_name==action_name.to_s ? "active" : nil
  end
end
