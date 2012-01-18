module PageHelper
  def title
    base_title = "Greetings"
    return "#{base_title} | #{@title}" unless @title.nil?
    return base_title
  end
end
