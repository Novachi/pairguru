# frozen_string_literal: true

class TitleBracketsValidator < ActiveModel::Validator
  VALID_BRACES_PAIRS = { '(' => ')', '[' => ']', '{' => '}' }

  def validate(record)
    validate_no_empty_brackets(record)
    validate_correct_braces_order(record)
  end

  def validate_no_empty_brackets(record)
    return unless record.title.include?('()') || record.title.include?('{}') ||  record.title.include?('[]')

    record.errors.add(:title, 'cannot contain empty brackets')
  end

  def validate_correct_braces_order(record)
    return if check_for_correct_braces_order(record.title)

    record.errors.add(:title, 'contains incorrect brackets')
  end

  private

  def check_for_correct_braces_order(title)
    opening_braces = []
    title.each_char do |character|
      if VALID_BRACES_PAIRS.keys.include?(character)
        opening_braces.append character
      elsif character == VALID_BRACES_PAIRS[opening_braces.last]
        opening_braces.pop
      elsif VALID_BRACES_PAIRS.values.include?(character) && VALID_BRACES_PAIRS[opening_braces.last] != character
        return false
      end
    end

    opening_braces.empty?
  end

  def check_for_bracket_pairs(title)
    VALID_OPENING_BRACES.each_with_index do |bracket, i |
      return false if title.count(bracket) != title.count(VALID_CLOSE_BRACES[i])
    end

    true
  end
end
