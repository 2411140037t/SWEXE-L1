class Book < ApplicationRecord
  # タイトル：必須・100文字以内・同じ著者で同じタイトルは登録不可
  validates :title, presence: true,
                    length: { maximum: 100 },
                    uniqueness: { scope: :author, message: "はこの著者ですでに登録されています" }

  # 著者：必須・50文字以内
  validates :author, presence: true, length: { maximum: 50 }

  # 出版年：必須・整数・西暦1年〜今年まで
  validates :published_year, presence: true,
                             numericality: {
                               allow_nil: true,
                               only_integer: true,
                               greater_than_or_equal_to: 1,
                               less_than_or_equal_to: ->(_book) { Date.current.year }
                             }
end