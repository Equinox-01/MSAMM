# frozen_string_literal: true

module Services
  class ApplicationService
    def self.check_distribution(distribution_string)
      case distribution_string
      when 'uniform'
        Algorithm::Distribution::Uniform
      when 'gaussian'
        Algorithm::Distribution::Gaussian
      when 'exponential'
        Algorithm::Distribution::Exponential
      when 'gamma'
        Algorithm::Distribution::Gamma
      when 'triangle'
        Algorithm::Distribution::Triangle
      when 'simpson'
        Algorithm::Distribution::Simpson
      end
    end
  end
end
