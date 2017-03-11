require "rspec_matcher_kata_banco/version"

module RspecMatcherKataBanco
  RSpec::Matchers.define :represent do |expect|
    index_errors = []
    match do |actual|
      expect.each_with_index do |e, i|
        index_errors << i if e != actual[i]
      end
      index_errors.empty?
    end

    failure_message_for_should do |actual|
      formated_actual = format_array(actual)
      formated_expected = format_array(expected)
      "expected\n#{formated_actual}\nto represent\n#{formated_expected}\n"\
        "errors found in #{index_errors.join(', ')}"
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
