class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :book_publishers do |t|
      t.string     :name,            null: false, unique: true
    end
    publishers = %w(수경출판사)
    publishers.each do |publisher|
      Standard::BookPublisher.create(name: publisher)
    end

    create_table :books do |t|
      t.references :subject,         null: false
      t.references :book_publisher,  null: false
      t.string     :name
      t.string     :series
      t.integer    :total_page
      t.date       :published_at
    end
    books = ['자이스토리 미적분I', '자이스토리 미적분II', '자이스토리 확률통계']
    books.each do |book|
      Standard::Book.create(name: book, subject_id: 3, book_publisher_id: 1, series: '자이스토리', total_page: 100, published_at: Date.today - 180.days)
    end

    create_table :book_units do |t|
      t.references :subject,         null: false
      t.references :book,            null: false
      t.integer    :order
      t.integer    :depth,           default: 0
      t.string     :name
      t.integer    :page
    end

    Standard::BookUnit.create(subject_id: 3, book_id: 1, page: 11, order: 0, depth: 0, name: "1. 집합과 명제")
    Standard::BookUnit.create(subject_id: 3, book_id: 1, page: 11, order: 1, depth: 1, name: "A 집합의 이해와 연산")
    Standard::BookUnit.create(subject_id: 3, book_id: 1, page: 13, order: 2, depth: 2, name: "Aa 집합의 표현과 분류")
    Standard::BookUnit.create(subject_id: 3, book_id: 1, page: 14, order: 3, depth: 2, name: "Ab 부분집합")
    Standard::BookUnit.create(subject_id: 3, book_id: 1, page: 14, order: 4, depth: 2, name: "Ac 집합의 연산")
    Standard::BookUnit.create(subject_id: 3, book_id: 1, page: 17, order: 5, depth: 2, name: "Ad 집합의 연산의 성질")
    Standard::BookUnit.create(subject_id: 3, book_id: 1, page: 18, order: 6, depth: 2, name: "Ae 집합의 연산과 부분집합의 개수")
    Standard::BookUnit.create(subject_id: 3, book_id: 1, page: 20, order: 7, depth: 2, name: "Af 집합의 연산법칙")
    Standard::BookUnit.create(subject_id: 3, book_id: 1, page: 22, order: 8, depth: 2, name: "Ag 유한집합의 원소의 개수")
    Standard::BookUnit.create(subject_id: 3, book_id: 1, page: 23, order: 9, depth: 2, name: "Ah 유한집합의 원소의 개수의 응용")
    Standard::BookUnit.create(subject_id: 3, book_id: 1, page: 24, order: 10, depth: 2, name: "최고난도 유형 Review")
  end
end
