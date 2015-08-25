class Space
  attr_accessor :space

  def space
    @space
  end

  def space=(arg)
    @space = arg
  end


  def filled?
    !space.nil?
  end

end
