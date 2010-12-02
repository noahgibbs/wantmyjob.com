@workplace_question_id = 10000
@workplace_question_answer_id = 10000

def next_question_id
  @workplace_question_id += 1
  @workplace_question_id
end

def next_qa_id
  @workplace_question_answer_id += 1
  @workplace_question_answer_id
end

def seed_workplace_question(question_text, answers)
  text_to_find = ""

  Question.seed do |s|
    s.id = next_question_id
    s.question_type = Question::WORKPLACE_QUESTION
    text_to_find = s.text = question_text
  end

  answers.each do |answer_text|
    QuestionAnswer.seed do |s|
      s.id = next_qa_id
      s.text = answer_text
      s.question_id = Question.where(:text => text_to_find).first
    end
  end
end

seed_workplace_question("Does <company> still exist and hire people?",
                        ["Yes", "No", "Not Right Now"])
seed_workplace_question("How well did you like working at <company>?",
                        ["It was awful", "It was bad", "Just a job",
                         "I enjoyed it", "I'd have done it for free"])
