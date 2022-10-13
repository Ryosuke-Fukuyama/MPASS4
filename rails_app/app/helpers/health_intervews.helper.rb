module VueHelper
  def vue(name, props, tag: :div)
    content_tag(tag, nil, "data-vue-component" => name, "data-vue-properties" => props.to_json)
  end
end