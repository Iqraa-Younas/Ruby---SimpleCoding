require 'nokogiri'
require 'open-uri'

def cropped_link(link)
  length = link.length
  croppedlink = nil
  if link.include?('www')
    index1 = link.index('www.')
    if link[(length-1)] == '/'
      croppedlink = link[(index1+4)..length-2]
    else
      croppedlink = link[(index1+4)..length]
    end

  else
    index1 = link.index('/')
    if link[(length-1)] == '/'
      croppedlink = link[(index1+2)..length-2]
    else
      croppedlink = link[(index1+2)..length]
    end
  end
  return croppedlink
end

def comparison_link(link)
  length = link.length
  croppedlink = nil
  if link.include?('www')
    index1 = link.index('www.')
    index1 = index1 + 4
    index2 = link.index('.',index1)
    croppedlink = link[(index1)..(index2+3)]


  else
    index1 = link.index('/')
    index1 = index1 + 2
    index2 = link.index('.')
    croppedlink = link[index1..(index2+3)]
  end
  return croppedlink
end

def make_link(link,site)
  if link.start_with?"//"
    link = "https://"+link[2..(link.length)]
  elsif link.start_with?"/"
    link = "https://"+site+link
  elsif link.start_with?"./"
    link = "https://"+site+link[1..(link.length)]
  end
  return link
end

begin
  site = "http://bsef18m545.000webhostapp.com"
  # site = "https://bsef18m545.000webhostapp.com/index.html"
  # site = "https://www.wikipedia.org/"
  # site = "https://khaadi.com/contact"

  # site = "https://khaadi.com/"
  links = Array.new
  visited_links = Array.new
  titles = Array.new
  links.push(site)

  links.each do |link|
    croppedlink = cropped_link(link)
    comparisonlink = comparison_link(link)


    begin
      document = Nokogiri::HTML.parse(open(link))
      if !titles.include?(document.title)
        titles.push(document.title)
        visited_links.push(link)
        tags = document.xpath("//a")
        tags.each do |tag|
          if tag[:href] != nil

            if !tag[:href].include?("@") && (tag[:href].start_with?("/[a..z]") || tag[:href].include?("#{comparisonlink}") || tag[:href].start_with?("./"))
              if !visited_links.include?(make_link(tag[:href],croppedlink)) && links.count(make_link(tag[:href],croppedlink)) < 1
                links.push(make_link(tag[:href],croppedlink))
              end
            end
          end
        end
      end
    rescue

    end

  end
  # puts links
  Doc_XML = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
    xml.urlset('xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9') do
      visited_links.each do |link|
        xml.url{
          xml.loc (link)
        }
      end
    end
  end
  puts Doc_XML.to_xml

















  # document = Nokogiri::HTML.parse(open(site))
  # tags = document.xpath("//a")
  # # index1 = site.index('/')
  # # length = site.length
  # puts cropped_link(site)
  #   tags.each do |tag|
  #     if tag[:href] != nil
  #       # puts tag[:href]
  #       if tag[:href].start_with?("#") || tag[:href].start_with?("#{site}") || tag[:href].start_with?("./") || tag[:href].start_with?("//")
  #         # puts "#{tag[:href]}\t#{tag.text}"
  #         # puts "OK"
  #         puts tag[:href]
  #       end
  #     end
  #   end
rescue NoMethodError => e
  puts e
end
