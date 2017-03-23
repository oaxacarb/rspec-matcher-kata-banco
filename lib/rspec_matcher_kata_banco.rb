require "rspec_matcher_kata_banco/version"

module RspecMatcherKataBanco
  RSpec::Matchers.define :represent do |expect|
    Error = Struct.new(:index, :actual, :expected) do
      def actual
        self[:actual].join("\n")
      end

      def expected
        self[:expected].join("\n")
      end

      def to_s
        "error found in index #{index} expected:\n#{expected}\nactual:\n#{actual}"
      end
    end

    errors = []
    match do |actual|
      expect.zip(actual).each_with_index do |(e, a), i|
        errors << Error.new(i, a, e) if e != a
      end
      errors.empty?
    end

    failure_message do |actual|
      <<~HEREDOC
        expected
        #{format_array(actual)}
        to represent
        #{format_array(expected)}
        #{errors.join("\n")}
      HEREDOC
    end

    def format_array(v)
      [
        v.map { |x| x[0] }.join,
        v.map { |x| x[1] }.join,
        v.map { |x| x[2] }.join
      ].join("\n")
    end
  end
end
