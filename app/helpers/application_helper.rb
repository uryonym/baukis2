module ApplicationHelper
  include HtmlBuilder

  def document_title
    @title.present? ? "#{@title} - Baukis2" : 'Baukis2'
  end
end
