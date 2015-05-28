class Route
  getter :pattern
  getter :controller
  getter :action
  getter :length

  def initialize(@pattern, @controller, @action)
    @pattern = @pattern.gsub(/\/$/, "") unless @pattern == "/"
    @length = @pattern.split("/").length
  end

  def matches?(path)
    return false unless path.gsub(/\/$/, "").split("/").length == @length
    regex = Regex.new(@pattern.to_s.gsub(/(:\w*)/, ".*"))
    path.match(regex) ? true : false
  end

  def get_params(path)
    params = {} of String => String
    path_items = path.split("/")
    pattern_items = @pattern.split("/")
    path_items.length.times do |i|
      if pattern_items[i].match(/(:\w*)/)
        params[pattern_items[i].gsub(/:/, "")] = path_items[i]
      end
    end
    return params
  end
end