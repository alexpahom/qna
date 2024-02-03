module AnswersPageHelper

  def first_answer_ranking
    Capybara.page.find('[class*=ranking]').text[/\d+/].to_i
  end

  def first_answer_rank_xpath
    '(//*[contains(@class, "answers")]//*[@class="rank-wrapper"])[1]'
  end

  def first_answer_xpath
    '(//*[contains(@class, "answers")]/div[contains(@id, answer)])[1]'
  end
end
