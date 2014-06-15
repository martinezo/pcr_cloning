module ApplicationHelper

  def jq_submit_tag(title)
    submit_tag title, :'jq-text' => true, :class => 'jq-button'
  end

  def jq_link_to(url, text, icon = nil , title = nil, remote = true)
    link_to text, url, :title => title, :remote => remote, :'jq-text' => true, :'jq-icon' => icon, :class => 'jq-button', data: { disable_with: 'Procesando...'}
  end

  def jq_icon_link_to(url, icon, title='&nbsp'.html_safe, remote = true)
    link_to title, url, :remote => remote, :'jq-icon' => icon, :class => 'jq-button'
  end

  def jq_link_to_destroy(url, text=nil, confirm = t('crud.confirm'), title='&nbsp'.html_safe, remote = true)
    link_to text.nil? ? "&nbsp".html_safe : text, url, :remote => remote, :'jq-icon' => 'trash', :class => 'jq-button', :'jq-text' => !text.nil?, :method => :delete, :data => { :confirm => confirm }
  end

end
