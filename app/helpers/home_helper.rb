module HomeHelper
  def active?(controller_name_action_name)
    "#{self.controller_name}##{self.action_name}"==controller_name_action_name ? "active" : nil
  end
end
