module AnswersPageHelper

  def first_answer_ranking
    Capybara.page.find('[class*=ranking]').text[/\d+/].to_i
  end

  def first_answer_xpath
    '(//*[@class="answers"]//*[@class="rank-wrapper"])[1]'
  end
end