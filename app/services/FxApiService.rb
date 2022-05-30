
require 'net/http'

class FxApiService
    attr_reader :request_params

    def initialize(request_params)
        @request_params = request_params
    end

    def get_rate
        request = Net::HTTP::Get.new(url)
        finalize_request(request)
    end


    private 

    
    def url
        URI("https://api.fastforex.io/fetch-all?api_key=feef5cb903-f9c11a2fd8-rcoo17&"+request_params)
    end

    def http
        http_obj = Net::HTTP.new(url.host, url.port)
        http_obj.use_ssl = true
        http_obj.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http_obj
    end

    def finalize_request(request_object)    
        request_object["content-type"] = "application/json"
        begin
            res = http.request(request_object)
            return JSON.parse(res.body)["results"]["USD"] if res.body
        rescue => e
            return e
        end
    end
    
end


