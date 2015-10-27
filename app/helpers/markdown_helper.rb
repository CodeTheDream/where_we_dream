module MarkdownHelper
  def complex_md_parser(text)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autoliink: true,
      strikethrough: true,
      underline: true,
      highlight: true,
      superscript: true,
      disable_indented_code_blocks: true,
      space_after_headers: true
    )
    markdown.render(text).html_safe
  end

  def simple_md_parser(text)
    markdown = Redcarpet::Markdown.new(RenderWithoutWrap.new(
      hard_wrap: true,
      disable_indented_code_blocks: true,
      space_after_headers: true,
      safe_links_only: true,
      autolink: true,
      escape_html: true,
      no_images: true,
    ))
    text = pound_filter text
    text = asterisk_filter text
    text = dash_filter text
    # text = number_filter text # ordered lists are still possible...Not really a big deal.
    markdown.render(text).html_safe
  end
  def pound_filter text
    text.gsub /^#/, '\#'
  end

  def asterisk_filter text
    text.gsub /^\*/, '\*'
  end

  def dash_filter text
    text.gsub /^-/, '\-'
  end

  # def number_filter text
  #   if text[/^\d./].present?
  #     text[/^\d./].each do |match|
  #       escape = '\\' + match
  #       text.gsub match, escape
  #     end
  #   end
  # end
end
