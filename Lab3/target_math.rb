class TargetMath
  def absolute_bandwidth(probability, lock_probability)
    (1 - probability) * (1 - lock_probability)
  end

  def average_number_of_request_in_system(probabilities)
    sum = 0
    probabilities.each { |probability| sum += (probability[0][1].to_i + 1) * probability[1] }
    sum
  end

  def average_time_spent_in_system(probability, lock_probability, probabilities)
    average_number_of_request_in_system(probabilities) / absolute_bandwidth(probability, lock_probability)
  end

  def time_in_system
    p = $states_probability
    lc = p['111']
    a = p['010'] * (1 - $pi1) +
        p['001'] * (1 - $pi2) +
        (p['011'] + p['111']) * ((1 - $pi1) * $pi2 + (1 - $pi2) * $pi1 + 2 * (1 - $pi1) * (1 - $pi2))
    return lc / a if lc / a != 0
    1
  end
end
