class Application 

    @@items = []

    def call(env)
        req = Rack::Request.new(env)
        resp =Rack::Response.new

        if req.path.match(/items/)
            find_item = extract(req.path)
            result = "Item not found"
            resp.status = 400
            @@items.each do |item|
                if item.name == find_item
                    result = item.price
                    resp.status = 200
                    break
                end
            end 
            resp.write(result)
        else 
            resp.write("Route not found")
            resp.status = 404
        end

        resp.finish
    end

    def extract(url)
        result = ""
        len = url.length
        len.times do |i|
            if url[len - (1 + i)] != '/'
                result += url[len - (1 + i)] 
            else 
                break
            end
        end
        return result.reverse
    end

end 