require 'net/http'
require 'net/https'
# Thanks Ilya! http://www.igvita.com/2006/09/07/validating-url-in-ruby-on-rails/
# Original credits: http://blog.inquirylabs.com/2006/04/13/simple-uri-validation/
# HTTP Codes: http://www.ruby-doc.org/stdlib/libdoc/net/http/rdoc/classes/Net/HTTPResponse.html

class UriValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    raise(ArgumentError, "A regular expression must be supplied as the :format option of the options hash") unless options[:format].nil? or options[:format].is_a?(Regexp)
    configuration = { :message => "is invalid or not responding", :format => URI::regexp(%w(http https)) }
    configuration.update(options)
    uri = URI.parse(value)
    http = Net::HTTP.new(uri.host, uri.port)
    if value =~ /(^(https):\/\/.*)/
    	http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		end
		request = Net::HTTP::Get.new(uri.request_uri)
    if value =~ configuration[:format]
      begin # check header response
        case http.request(request)
          when Net::HTTPSuccess then true
          when Net::HTTPRedirection then true
          else object.errors.add(attribute, configuration[:message]) and false
        end
      rescue # Recover on DNS failures..
        object.errors.add(attribute, configuration[:message]) and false
      end
    else
      object.errors.add(attribute, configuration[:message]) and false
    end
  end
end


