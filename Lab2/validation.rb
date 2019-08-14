class Validation
  def initialize(type, args)
    raise ArgumentError, 'Необходимо указать тип распределения' if type.nil?

    @type = type
    @args = args
  end

  def validate
    raise ArgumentError unless send("#{@type}_valid?")
  end

  private

  def uniform_valid?
    raise ArgumentError, 'Параметр а должен быть меньше либо равен b' unless @args['a'].to_f <= @args['b'].to_f

    true
  end

  def gaussian_valid?
    raise ArgumentError, 'Параметр среднеквадратического отклонения должен быть больше 0' unless @args['scale'].to_f > 0

    true
  end

  def exponential_valid?
    raise ArgumentError, 'Параметр интенсивности должен быть больше 0' unless @args['rate'].to_f > 0

    true
  end

  def gamma_valid?
    raise ArgumentError, 'Параметр k должен быть больше 0' unless @args['shape'].to_f > 0
    raise ArgumentError, 'Параметр θ должен быть больше 0' unless @args['scale'].to_f > 0

    true
  end

  def triangle_valid?
    raise ArgumentError, 'Параметр а должен быть меньше либо равен b' unless @args['a'].to_f <= @args['b'].to_f

    true
  end

  def simpson_valid?
    raise ArgumentError, 'Параметр а должен быть меньше либо равен b' unless @args['a'].to_f <= @args['b'].to_f

    true
  end
end
