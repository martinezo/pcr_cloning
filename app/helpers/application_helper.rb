module ApplicationHelper

  def sortable(column, title=nil, url)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    (column == sort_column && sort_direction == "asc") ? title << " \u25B2" : title << " \u25BC"
    link_to title, "#{url}?direction=#{direction}&sort=#{column}" << (params[:search] ? "&search=#{params[:search]}" : ''), remote: true, class: 'sortable'
  end

  def link_to_jq_button(options)
    url = options[:url]
    text = options[:text] || '&nbsp'.html_safe
    jq_text = !options[:text].nil?
    title = options[:title] || nil
    remote = options[:remote].nil? ? true : options[:remote]
    data = options[:data] || nil
    icon = options[:icon] || nil
    id = options[:id] || nil
    htm_class = 'jq-button' << (options[:htm_class] ? ",#{html_class}" : '')
    target = options[:target] || nil
    link_to text, url, title: title, remote: remote, data: data, 'jq-icon'=> icon, id: id, class: htm_class, 'jq-text' => jq_text, target: target
  end

  def link_to_fa_button(options)
    url = options[:url]
    text = options[:text] ? "<span>&nbsp#{options[:text]}</span>" : ''
    title = options[:title] || nil
    remote = options[:remote].nil? ? true : options[:remote]
    data = options[:data] || nil
    icon = options[:icon] || nil
    id = options[:id] || nil
    htm_class = "fa fa-border fa-btn #{icon} " << (options[:htm_class] ? ",#{html_class}" : '')
    target = options[:target] || nil
    link_to text.html_safe, url, title: title, remote: remote, data: data, id: id, class: htm_class, target: target
  end

  def submit_tag_fa_button(text, data=nil)
    submit_tag text, :class => 'fa fa-border fa-btn', data: data
  end

  def jq_submit_tag(title, data=nil)
    submit_tag title, :'jq-text' => true, :class => 'jq-button', data: data
  end

end
