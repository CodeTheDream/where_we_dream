module MarkdownHelper
  def full_md(text)
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

  def simple_md(text)
    markdown = Redcarpet::Markdown.new(RenderWithoutWrap.new(
      hard_wrap: true,
      disable_indented_code_blocks: true,
      space_after_headers: true,
      safe_links_only: true,
      autolink: true,
      escape_html: true,
      no_images: true,
    ))
    text = plus_filter dash_filter asterisk_filter pound_filter text
    markdown.render(text).html_safe
  end

  def asterisk_filter text
    text.gsub /^\*\s{1}/, '\* '
  end

  def pound_filter text
    text.gsub /^#/, '\#'
  end

  def dash_filter text
    text.gsub /^-/, '\-'
  end

  def plus_filter text
    text.gsub /^\+/, '\+'
  end
end
