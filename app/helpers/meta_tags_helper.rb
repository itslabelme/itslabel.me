module MetaTagsHelper

  def page_title
    @page_title || "<Not Set>"
  end

  def page_heading
    @page_heading || "<Not Set>"
  end

  def meta_tags
    @meta_tags = {} unless @meta_tags
    @meta_tags.reverse_merge!(
      "content-type" => {"http-equiv": "Content-Type", "content": "text/html; charset=UTF-8"},
      "charset" => {"charset": "UTF-8"},
      "viewport" => {"name": "viewport", "content": "width=device-width, initial-scale=1, shrink-to-fit=no"},
      "content-language" => {"content-language": "en"},
      "description" => {"name": "description", "content": ""},
      "keywords" => {"name": "keywords", "content": ""},
      "author" => {"name": "author", "content": "Felix Koders"},
      "copyright" => {"name": "copyright", "content": "2018 &copy Right IT Solutions"},
      "x-ua-compatible" => {"http-equiv": "X-UA-Compatible", "content": "IE=edge"},
    )
    
    meta_tags_list = []
    @meta_tags.each do |name, tag_values|
      meta_tags_list << content_tag(:meta, "", tag_values)
    end

    raw(meta_tags_list.join(" "))
  end

  # This feature is not yet implemented.
  # This is implemented in SBIDU - Dhatu Plugin
  # You will have a feature object in all page and that object can have multiple meta tags
  def dynamic_meta_tags
    @meta_tag_object = (@r_object || @page)
    return unless @meta_tag_object
    return unless @meta_tag_object.respond_to?(:meta_tags)
    meta_tags_list = []

    @meta_tag_object.meta_tags.each do |meta_tag|
      meta_tags_list << content_tag(:meta, "", name: meta_tag.meta_key, content: meta_tag.meta_value)
    end

    raw(meta_tags_list.join(" "))
  end
end
