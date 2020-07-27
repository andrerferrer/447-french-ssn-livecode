require 'date'
require 'yaml'

def extract_data(match_data)
  data_hash = {}

  # access the gender and transform it from a number to a word: man || woman
  # puts "match_data[:gender] is #{match_data[:gender]}"
  # puts "match_data[:gender].class is #{match_data[:gender].class}"
  data_hash[:gender] = (match_data[:gender] == '1' ? 'man' : 'woman')
  # if match_data[:gender] == 1
  #   data_hash[:gender] = 'man'
  # else
  #   data_hash[:gender] = 'woman'
  # end
  # puts "data_hash[:gender] is #{data_hash[:gender]}"

  # access the birth year and concatenate '19' to it
  # data_hash[:birth_year] = '19' + match_data[:birth_year]
  data_hash[:birth_year] = "19#{match_data[:birth_year]}"
  # puts "data_hash[:birth_year] is #{data_hash[:birth_year]}"

  # access the birth month and turn this number into a word
  month_names = Date::MONTHNAMES
  month_number = match_data[:birth_month].to_i
  data_hash[:birth_month] = month_names[month_number]
  # puts "data_hash[:birth_month] = #{data_hash[:birth_month]}"
  # access the department of birth and turn this number into the name of the department
  departments = YAML.load_file('data/french_departments.yml')
  department = match_data[:department]
  data_hash[:department] = departments[department]
  # puts "data_hash[:department] = #{data_hash[:department]}"
  data_hash
end

def verifier_is_valid?(verifier, ssn)
  verifier = verifier.to_i
  ssn_without_verifier = ssn[0..-3].gsub(' ', '').to_i
  weird_math_result = 97 - ssn_without_verifier % 97
  weird_math_result == verifier
end

def french_ssn(ssn)
  regexp = /^(?<gender>[12])\s?
             (?<birth_year>\d{2})\s?
             (?<birth_month>0[1-9]|1[0-2])\s?
             (?<department>\d{2}|2[AB])\s?\d{3}\s?\d{3}\s?
             (?<verifier>\d{2})$/x

  match_data = ssn.match(regexp)
  # check whether the ssn is valid
  # check the verifier and do a weird math to check if it's valid
  return 'invalid ssn number' if !match_data || !verifier_is_valid?(match_data[:verifier], ssn)

  data_hash = extract_data(match_data)

  # build a meaningful message with the data that was extracted
  "a #{data_hash[:gender]}, born in #{data_hash[:birth_month]}, #{data_hash[:birth_year]} in #{data_hash[:department]}."
end

# This is how it's going to work
# french_ssn_info("1 84 12 76 451 089 46")
# => "a man, born in December, 1984 in Seine-Maritime."
