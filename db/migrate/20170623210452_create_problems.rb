class CreateProblems < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string     :name,            null: false, unique: true
      t.integer    :order,           unique: true
      t.integer    :depth
      t.string     :path
      t.references :subject
      t.references :main_subject
    end
    subjects = %w(국어 영어 수학)
    subjects.each_with_index do |name, index|
      order = (index + 1) * 1_000_000
      Subject.create(name: name, order: order, depth: 0, path: name)
    end

    kor_subjects = {
      '종합' => [],
      '화법' => [],
      '작문' => [],
      '문법' => [],
      '비문학' => ['인문', '사회', '과학', '기술', '예술', '언어', '철학'],
      '문학' => ['현대소설', '현대시', '고전소설', '고전시가', '수필']
    }
    kor_subjects.each_with_index do |(name, data), index|
      order = 1_000_000 + (index + 1) * 10_000
      path = '국어 > ' + name
      d1 = Subject.create(name: name, order: order, depth: 1, path: path, subject_id: 1, main_subject_id: 1)
      data.each do |name2|
        order += 100
        path2 = path + ' > ' + name2
        Subject.create(name: name2, order: order, depth: 2, path: path2, subject_id: d1.id, main_subject_id: 1)
      end
    end

    eng_subjects = {
      '단어' => [],
      '듣기' => ['짧은 대화', '말의 목적', '의견 묻기', '두 사람의 관계', '대화 내용 일치', '적절한 것 고르기', '여행 취소 이유', '금액 묻기', '언급되지 않는 것', '내용일치 묻기', '도표문제', '긴 대화 응답하기', '상황 설명 듣고 답하기', '글의 주제 묻기', '내용 파악'],
      '독해' => ['글의 목적', '심경 묻기', '글의 요지', '글의 주제', '글의 제목', '도표문제', '내용 일치', '안내문 일치/불일치', '어법', '어휘', '지칭추론', '빈칸추론(어휘)', '빈칸추론(구절)', '무관한 문장', '글의 순서', '문장 넣기', '요약하기', '순서 배열']
    }
    eng_subjects.each_with_index do |(name, data), index|
      order = 2_000_000 + (index + 1) * 10_000
      path = '영어 > ' + name
      d1 = Subject.create(name: name, order: order, depth: 1, path: path, subject_id: 2, main_subject_id: 2)
      data.each do |name2|
        order += 100
        path2 = path + ' > ' + name2
        Subject.create(name: name2, order: order, depth: 2, path: path2, subject_id: d1.id, main_subject_id: 2)
      end
    end

    math_subjects = {
      # '종합' => {},
      # '수학I' => {
      #   '다항식' => ['다항식의 연산', '나머지 정리', '인수분해'],
      #   '방정식과 부등식 > 복소수와 이차방정식' => ['복소수', '복소수의 사칙연산', '이차방정식의 실근과 허근', '이차방정식의 판별식', '이차방정식의 근과 계수의 관계'],
      #   '방정식과 부등식 > 이차방정식과 이차함수' => ['이차함수와 이차방정식의 관계', '이차함수의 그래프와 직선의 위치 관계', '이차함수의 최대/최소'],
      #   '방정식과 부등식 > 여러가지 방정식' => ['삼차방정식과 사차방정식', '연립방정식'],
      #   '방정식과 부등식 > 여러가지 부등식' => ['절댓값을 포함한 일차부등식', '이차 부등식'],
      #   '도형의 방정식 > 평면좌표' => ['두 점 사이의 거리', '선분의 내분과 외분'],
      #   '도형의 방정식 > 직선의 방정식' => ['직선의 방정식', '두 직선의 평행과 수직', '점과 직선 사이의 거리'],
      #   '도형의 방정식 > 원의 방정식' => ['원의 방정식', '원과 직선의 위치 관계'],
      #   '도형의 방정식 > 도형의 이동' => ['평행이동', '대칭이동'],
      #   '도형의 방정식 > 부등식의 영역' => ['부등식의 영역', '부등식의 영역의 활용']
      # },
      '수학II' => {
        '집합' => ['집합의 뜻과 표현', '집합 사이의 포함 관계', '집합의 연산', '드모르간의 법칙'],
        '명제' => ['명제와 조건', '명제 사이의 관계', '명제의 증명'],
        '함수' => ['함수의 뜻과 그래프', '합성함수', '역함수'],
        '유리함수와 무리함수' => ['유리함수', '무리함수'],
        '수열 > 등차수열과 등비수열' => ['수열의 뜻', '등차수열', '등비수열'],
        '수열 > 수열의 합' => ['합의 기호', '여러 가지 수열의 합'],
        '수열 > 수학적 귀납법' => ['수열의 귀납적 정의', '수학적 귀납법'],
        '지수' => ['거듭제곱과 거듭제곱근', '지수의 확장과 지수법칙'],
        '로그' => ['로그의 뜻과 성질', '상용로그']
      },
      '미적분I' => {
        '수열의 극한' => ['수열의 수렴과 발산', '극한값의 계산', '등비수열의 극한'],
        '급수' => ['급수의 수렴과 발산', '등비급수', '등비급수의 활용'],
        '함수의 극한' => ['함수의 극한', '함수의 극한에 대한 성질'],
        '함수의 연속' => ['함수의 연속', '연속함수의 성질'],
        '다항함수의 미분법 > 미분계수와 도함수' => ['미분계수', '도함수'],
        '다항함수의 미분법 > 도함수의 활용' => ['접선의 방정식', '평균값 정리', '함수의 증가와 감소, 극대와 극소', '함수의 그래프와 최대, 최소', '방정식과 부등식에의 활용', '속도와 가속도'],
        '다항함수의 적분법 > 부정적분' => ['부정적분', '부정적분의 계산'],
        '다항함수의 적분법 > 정적분' => ['구분구적법', '정적분', '정적분의 계산'],
        '다항함수의 적분법 > 정적분의 활용' => ['넓이', '속도와 거리']
      },
      '미적분II' => {
        '지수함수와 로그함수의 뜻과 그래프' => ['지수함수와 로그함수의 뜻', '지수함수와 로그함수의 그래프', '지수함수와 로그함수의 활용'],
        '지수함수와 로그함수의 미분' => ['지수함수와 로그함수의 극한', '지수함수와 로그함수의 미분법'],
        '삼각함수의 뜻과 그래프' => ['일반각과 호도법', '삼각함수의 뜻', '삼각함수의 그래프', '삼각함수의 활용'],
        '삼각함수의 미분' => ['삼각함수의 덧셈정리', '삼각함수의 극한', '삼각함수의 미분법'],
        '미분법 > 여러가지 미분법' => ['함수의 몫의 미분법', '합성함수의 미분법', '역함수의 미분법', '이계도함수'],
        '미분법 > 도함수의 활용' => ['접선의 방정식', '함수의 그래프', '방정식과 부등식에의 활용'],
        '적분법 > 부정적분' => ['여러 가지 함수의 부정적분', '치환적분법', '부분적분법'],
        '적분법 > 정적분' => ['여러 가지 함수의 정적분', '정적분의 치환적분법', '정적분의 부분적분법'],
        '적분법 > 정적분의 활용' => ['넓이', '부피']
      },
      '확률과 통계' => {
        '순열과 조합 > 경우의 수' => ['경우의 수'],
        '순열과 조합 > 순열' => ['순열', '원순열', '중복순열', '같은 것이 있는 순열'],
        '순열과 조합 > 조합' => ['조합', '중복조합'],
        '순열과 조합 > 분할과 이항정리' => ['분할', '이항정리'],
        '확률' => ['확률의 뜻', '확률의 덧셈정리', '조건부 확률', '사건의 독립'],
        '통계 > 확률분포' => ['확률변수와 확률분포', '이산확률변수의 기댓값과 표준편차', '이항분포', '정규분포'],
        '통계 > 통계적 추정' => ['모집단과 표본', '모평균의 추정', '모비율의 추정']
      },
      '기하와 벡터' => {
        '평면곡선 > 이차곡선' => ['포물선', '타원', '쌍곡선'],
        '평면곡선 > 평면곡선의 접선' => ['음함수의 미분과 접선의 방정식', '매개변수로 나타내어진 함수의 미분과 접선의 방정식'],
        '평면벡터 > 벡터의 연산' => ['벡터의 뜻', '벡터의 덧셈과 뺄샘', '벡터의 실수배'],
        '평면벡터 > 평면벡터의 성분과 내적' => ['위치벡터', '벡터의 성분', '벡터의 내적', '직선과 원의 방정식'],
        '평면벡터 > 평면 운동' => ['미분법을 이용한 속도와 가속도', '정적분을 이용한 속도와 거리'],
        '공간도형' => ['직선과 평면의 위치 관계', '평행과 수직', '정사영'],
        '공간좌표' => ['점의 좌표', '두 점 사이의 거리', '선분의 내분과 외분', '구의 방정식'],
        '공간벡터' => ['공간벡터의 성질', '공간벡터의 내적', '좌표공간에서 직선의 방정식', '평면과 구의 방정식']
      }
    }
    math_subjects.each_with_index do |(name, data), index|
      order = 3_000_000 + (index + 1) * 10_000
      path = '수학 > ' + name
      d1 = Subject.create(name: name, order: order, depth: 1, path: path, subject_id: 3, main_subject_id: 3)
      data.each_with_index do |(name2, data2), index2|
        order = 3_000_000 + (index + 1) * 10_000 + (index2 + 1) * 100
        path2 = path + ' > ' + name2
        d2 = Subject.create(name: name2, order: order, depth: 2, path: path2, subject_id: d1.id, main_subject_id: 3)
        data2.each_with_index do |name3, index3|
          order = 3_000_000 + (index + 1) * 10_000 + (index2 + 1) * 100 + (index3 + 1) * 1
          path3 = path2 + ' > ' + name3
          Subject.create(name: name3, order: order, depth: 3, path: path3, subject_id: d2.id, main_subject_id: 3)
        end
      end
    end

    create_table :problem_sources do |t|
      t.string     :name,            null: false, unique: true
    end
    # sources = %w(일일테스트 수능 모의고사)
    # sources.each do |s|
    #   ProblemSource.create(name: s)
    # end
    sources = %w(영어듣기 영어단어 수학가형 수학나형)
    sources.each do |s|
      ProblemSource.create(name: s)
    end

    create_table :problem_collections do |t|
      t.references :subject,         null: false
      t.references :problem_source,  null: false
      t.string     :name,            null: false
      t.integer    :problem_count,   default: 0
      t.integer    :total_score,     default: 0
      t.date       :test_day
      t.boolean    :published,       default: false
      t.integer    :solved_count,    default: 0
      t.timestamps
    end

    create_table :problems do |t|
      t.references :subject,        null: false
      t.integer    :level
      t.integer    :score,          default: 0
      t.text       :content,        limit: 16.megabytes - 1
      t.text       :exm_1
      t.text       :exm_2
      t.text       :exm_3
      t.text       :exm_4
      t.text       :exm_5
      t.string     :answer
      t.text       :explanation,    limit: 16.megabytes - 1
      t.integer    :total_count,    default: 0
      t.integer    :correct_count,  default: 0
      t.references :problem
      t.boolean    :set
      t.attachment :audio
      t.timestamps
    end

    create_table :problem_collection_to_problems do |t|
      t.references :problem_collection,  null: false
      t.references :problem,             null: false
      t.integer    :order
    end

    User.create(uid: '01088627156', password: 'test1234', name: '안준식', gender: true, birthday: '1986-11-21', liberal: true)

    # ProblemCollection.create(subject_id: 2, problem_source_id: 1, name: '영어듣기 일일테스트', problem_count: 3, total_score: 30, test_day: Date.parse('2017-07-21'), published: true)
    # ProblemCollection.create(subject_id: 2, problem_source_id: 2, name: '영어단어 일일테스트', problem_count: 3, total_score: 30, test_day: Date.parse('2017-07-21'), published: true)
    # ProblemCollection.create(subject_id: 3, problem_source_id: 3, name: '수학가형 일일테스트', problem_count: 3, total_score: 30, test_day: Date.parse('2017-07-21'), published: true)
    # ProblemCollection.create(subject_id: 3, problem_source_id: 4, name: '수학나형 일일테스트', problem_count: 3, total_score: 30, test_day: Date.parse('2017-07-21'), published: true)
    #
    # Problem.create(subject_id: 2, content: '영어듣기 테스트 1번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    # Problem.create(subject_id: 2, content: '영어듣기 테스트 2번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    # Problem.create(subject_id: 2, content: '영어듣기 테스트 3번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    # Problem.create(subject_id: 2, content: '영어단어 테스트 1번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    # Problem.create(subject_id: 2, content: '영어단어 테스트 2번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    # Problem.create(subject_id: 2, content: '영어단어 테스트 3번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    # Problem.create(subject_id: 3, content: '수학가형 테스트 1번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    # Problem.create(subject_id: 3, content: '수학가형 테스트 2번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    # Problem.create(subject_id: 3, content: '수학가형 테스트 3번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    # Problem.create(subject_id: 3, content: '수학나형 테스트 1번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    # Problem.create(subject_id: 3, content: '수학나형 테스트 2번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    # Problem.create(subject_id: 3, content: '수학나형 테스트 3번 문제입니다', exm_1: '1', exm_2: '2', exm_3: '3', exm_4: '4', exm_5: '5', answer: '3', score: 10)
    #
    # ProblemCollectionToProblem.create(problem_collection_id: 1, problem_id: 1, order: 0)
    # ProblemCollectionToProblem.create(problem_collection_id: 1, problem_id: 2, order: 1)
    # ProblemCollectionToProblem.create(problem_collection_id: 1, problem_id: 3, order: 2)
    # ProblemCollectionToProblem.create(problem_collection_id: 2, problem_id: 4, order: 0)
    # ProblemCollectionToProblem.create(problem_collection_id: 2, problem_id: 5, order: 1)
    # ProblemCollectionToProblem.create(problem_collection_id: 2, problem_id: 6, order: 2)
    # ProblemCollectionToProblem.create(problem_collection_id: 3, problem_id: 7, order: 0)
    # ProblemCollectionToProblem.create(problem_collection_id: 3, problem_id: 8, order: 1)
    # ProblemCollectionToProblem.create(problem_collection_id: 3, problem_id: 9, order: 2)
    # ProblemCollectionToProblem.create(problem_collection_id: 4, problem_id: 10, order: 0)
    # ProblemCollectionToProblem.create(problem_collection_id: 4, problem_id: 11, order: 1)
    # ProblemCollectionToProblem.create(problem_collection_id: 4, problem_id: 12, order: 2)
  end
end
