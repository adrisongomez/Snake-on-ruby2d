class Calculator
  def add(a, b)
    a + b
  end

  def subtract(a, b)
    a - b
  end

  def multiply(a, b)
    a * b
  end

  def divide(a, b)
    a / b
  end
end

calc = Calculator.new
expected_results = {
	[1, 2] => 3,
	[5,6]=> 30,
}
expected_results.each do |input, exepect_result|
	calc.add(input[0], input[1]) == exepect_result
end