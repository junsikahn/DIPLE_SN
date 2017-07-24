class Admin::ProblemCollection < Standard::ProblemCollection
  attr_accessor :excel

  has_many :admin_problems, class_name: 'Admin::Problem', through: :problem_collection_to_problems, source: :problem

  def create_word_test(file)
    # 엑셀파일 읽기
    wb = RubyXL::Parser.parse(file)
    ws = wb[0]

    data = []
    ws.each_with_index do |row, index|
      next if index.zero?
      pair = {eng: '', kor: ''}
      row && row.cells.each_with_index do |cell, index2|
        next if index2 > 2
        pair[:eng] = cell.value.strip if cell && index2.zero?
        pair[:kor] = cell.value.strip if cell && index2 == 1
      end
      data << pair
    end

    data.each do |pair|
      word_list = data.pluck(:kor) - [pair[:kor]]
      word_list = word_list.shuffle
      exms = []
      3.times do |index|
        exms << word_list.shift
      end
      exms << pair[:kor]
      exms = exms.shuffle
      answer = (exms.index(pair[:kor]) + 1).to_s

      problems.build(subject_id: 22, score: 1, content: pair[:eng], exm_1: exms[0], exm_2: exms[1], exm_3: exms[2], exm_4: exms[3], answer: answer)
    end
  end
end
