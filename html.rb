class HTML
  # Example without using method_missing:
  # module TagDefiner
  #   def tags(*names)
  #     names.each do |tag|
  #       define_method(tag) do |text = nil, **attrs, &html|
  #         opening_tag = "<#{tag}#{attrs.any? ? " #{serialize_attrs(attrs)}" : ""}>"
  #         closing_tag = "</#{tag}>"
  #         content = html ? "\n#{HTML.new(depth: @depth + 1, &html)}\n" : text
  #
  #         @elements << "#{opening_tag}#{content}#{html ? indent(closing_tag) : closing_tag}"
  #       end
  #     end
  #   end
  # end
  #
  # private_constant :TagDefiner
  #
  # extend TagDefiner
  #
  # tags :h1, :h2, :h3, :div

  def initialize(depth: 0, &html)
    @elements = []
    @depth = depth

    instance_eval(&html)
  end

  def method_missing(tag, text = nil, **attrs, &html)
    opening_tag = "<#{tag}#{attrs.any? ? " #{serialize_attrs(attrs)}" : ""}>"
    closing_tag = "</#{tag}>"
    content = html ? "\n#{HTML.new(depth: @depth + 1, &html).render}\n" : text

    @elements << "#{opening_tag}#{content}#{html ? indent(closing_tag) : closing_tag}"
  end

  def render
    @elements.map { |element| indent(element) }.join("\n")
  end

  private

  def serialize_attrs(attrs)
    attrs.map { |attr, value| "#{attr}=\"#{value}\"" }.join(" ")
  end

  def indent(element)
    "  " * @depth + element.to_s
  end
end

html = HTML.new do
  h1 "Title"
  h1 class: "abc", id: 3 do
    h2 "Inner Title"
    div do
      h1 "Inner Inner Title", lol: "wut"
      h3 "Inner Inner Title"
    end
    h1 "Inner Title"
  end
end

puts html.render
