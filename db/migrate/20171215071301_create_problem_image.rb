class CreateProblemImage < ActiveRecord::Migration[5.0]
  def change
    create_table :problem_images do |t|
      t.attachment :image,   null: false
      t.references :problem
      t.timestamps null: false
    end

    add_column :problems, :is_objective, :boolean, default: true

    add_column :problems, :correct_ratio, :integer
    add_column :problems, :exm_1_ratio, :integer
    add_column :problems, :exm_2_ratio, :integer
    add_column :problems, :exm_3_ratio, :integer
    add_column :problems, :exm_4_ratio, :integer
    add_column :problems, :exm_5_ratio, :integer

    add_column :problem_sources, :year, :integer
    add_column :problem_sources, :time, :integer
    add_column :problem_sources, :subject_id, :integer
    add_column :problem_sources, :curriculum, :integer
    add_column :problem_sources, :grade, :integer


    # Problem.where('exm_1 = "" OR exm_1 IS NULL').update_all(is_objective: false)
    #
    # ProblemSource.all.each do |source|
    #   info = source.name.split('_')
    #   source.year = info[0][0..3].to_i
    #   source.time = info[1] == '대학수학능력시험' ? 11 : info[1][0].to_i
    #   source.subject_id = 3
    #   # source.curriculum = info[2][2] == '가' ? 2 : info[2][2] == '나' ? 1 : 0 # FIXME 한글 인식 오류 있음
    #   source.grade = 3
    #   source.save
    # end

    # ProblemSource.all.each do |source|
    #   new_name = []
    #   new_name.push "#{source.year}학년도"
    #   new_name.push source.time == 11 ? '대학수학능력시험' : "#{source.time}월"
    #   new_name.push '수학'
    #   if source.year == 2014 || source.year == 2015
    #     new_name.push source.curriculum == 1 ? '나형(A형)' : source.curriculum == 2 ? '가형(B형)' : '공통'
    #   else
    #     new_name.push source.curriculum == 1 ? '나형' : source.curriculum == 2 ? '가형' : '공통'
    #   end
    #   new_name.push "고#{source.grade}"
    #
    #   source.name = new_name.join('_')
    #   source.save
    # end
  end
end
