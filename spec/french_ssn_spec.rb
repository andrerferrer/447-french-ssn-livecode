require_relative '../french_ssn'


describe "#french_ssn" do

  it "returns 'invalid ssn number' when given '123' " do
    result = french_ssn('123')
    expected_result = 'invalid ssn number'
    expect(result).to eq(expected_result)
  end

  it "returns 'a man, born in December, 1984 in Seine-Maritime.' when given '1 84 12 76 451 089 46' " do
    result = french_ssn('1 84 12 76 451 089 46')
    expected_result = 'a man, born in December, 1984 in Seine-Maritime.'
    expect(result).to eq(expected_result)
  end

  it "returns 'a woman, born in October, 1992 in Ain.' when given '2 92 10 01 451 089 45' " do
    result = french_ssn('2 92 10 01 451 089 45')
    expected_result = 'a woman, born in October, 1992 in Ain.'
    expect(result).to eq(expected_result)
  end

  it "returns 'invalid ssn number' when given '2 92 10 01 451 089 99' " do
    result = french_ssn('2 92 10 01 451 089 99')
    expected_result = 'invalid ssn number'
    expect(result).to eq(expected_result)
  end

end
