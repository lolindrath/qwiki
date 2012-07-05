module PagesHelper
  # takes a page name
  # and returns the rendered html
  def page_to_html(page_name)
    page = Page.find(:first, :conditions => ['LOWER(name) = ?', page_name.downcase])

    if page.nil?
      return ''
    else
      return wiki_to_html(page.body)
    end
  end

  def wikify(body)
    # attachment special syntax {{file.png}}
    body.gsub!(/\{\{([\w\d _\.]+)\}\}/) do |s|
      asset = Asset.find(:first, :conditions => ["data_file_name = ?", $1])
      if !asset.nil?
        if asset.data_content_type == 'image/png' || asset.data_content_type == 'image/gif' || asset.data_content_type == 'image/jpg'
          %Q(!#{asset.url(:small)})
        else
          %Q("#{asset.data_file_name}":#{asset.url})
        end
      end
    end

    # just a regular wikiword
    body.gsub!(/\[\[([\w\d _\.]+)\]\]/) do |s|
      # see if page exists
      if Page.find(:first, :conditions => ["name = ?", $1])
        "[#{$1}](#{page_url($1)})"
      else
        "[#{$1}](#{new_page_url(:id => $1)})"
      end
    end


    body
  end

  # converts the WikiWords to links
  def wiki_to_html(body)
    Maruku.new(wikify(body)).to_html
  end

end
