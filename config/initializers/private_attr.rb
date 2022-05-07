module PrivateAttr

  def private_attr_reader(*method_names)
    attr_reader(*method_names)
    private(*method_names)
  end

  def private_attr_writer(*method_names)
    attr_writer(*method_names)
    private(*method_names.map { |name| "#{name}=" })
  end

  def private_attr_accessor(*method_names)
    private_attr_reader(*method_names)
    private_attr_writer(*method_names)
  end

  def private_delegate(*method_names, args)
    private(*delegate(*method_names, args))
  end
end
