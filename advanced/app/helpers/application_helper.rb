module ApplicationHelper
  SITE_NAME = "本の管理".freeze

  # <title>に入れる文字列。各ページで content_for :title を指定すると「ページ名 | 本の管理」になる
  def page_title
    content_for?(:title) ? "#{content_for(:title)} | #{SITE_NAME}" : SITE_NAME
  end

  # 表示中のページへのリンクなら is-active クラスと aria-current を付ける link_to
  # active: で強調するかどうかを明示的に指定することもできる
  def nav_link_to(name, path, active: nil, **options)
    active = current_page?(path) if active.nil?
    classes = [options.delete(:class), ("is-active" if active)].compact
    options[:class] = classes.join(" ") if classes.any?
    options[:aria] = { current: "page" } if active
    link_to name, path, **options
  end

  # 一覧ページ（/ と /books の両方）を表示しているか
  def books_index_page?
    controller_name == "books" && action_name == "index"
  end

  # サイドバー用：新しく登録された本を新しい順に取り出す
  def recent_books(limit = 5)
    Book.order(created_at: :desc).limit(limit)
  end

  # 日付を「10/08」のような短い形にする
  def short_date(time)
    time.strftime("%m/%d")
  end
end