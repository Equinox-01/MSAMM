class MathSequence
  EPS = 0.0001

  def self.p_failure(m)
    tmp = ((($p**($n + m)) / (($n**m) * Math.gamma($n + 1))) * MathSequence.p0_calculate(m)).to_f
    add_distortion(tmp)
  end

  def self.parking_loading(m)
    tmp = (($n**$n) / (Math.gamma($n + 1))) * ((m * (m + 1)) / 2) * MathSequence.p0_calculate(m)
    add_distortion(tmp)
  end

  def self.p0_calculate(m)
    tmp = 2
    $n.times.each { |n_tmp| tmp += ($n**n_tmp) / Math.gamma(n_tmp + 1) }
    tmp += (($n**$n) / Math.gamma($n + 1)) * m
    tmp = tmp**(-1)
    add_distortion(tmp)
  end

  def self.profit(m)
    tmp = (1 - MathSequence.p_failure(m)) * $intense * $price_process * $n - m * $price_queue
    add_distortion(tmp)
  end

  def self.add_distortion(indata)
    return 1 if indata == Float::INFINITY

    tmp = rand((indata - EPS).to_f..(indata + EPS).to_f)
    if tmp >= 0
      return tmp
    else
      return 0
    end
  end
end
