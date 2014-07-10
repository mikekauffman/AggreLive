class Search < ActiveRecord::Base
  belongs_to :user

  def url_safe_term
    if term.include?(',')
      term.delete(',').split.map { |term| term }.join('+')
    else
      term.split.map { |term| term }.join('+')
    end
  end

end
