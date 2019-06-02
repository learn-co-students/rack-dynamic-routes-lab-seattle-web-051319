require 'pry'

class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    found_item = nil
    if !req.path.match(/items/)
      resp.write "Route not found"
      resp.status = 404
    else
      item_name = req.path.split("/items/").last
      found_item = @@items.find do |item|
        item.name == item_name
      end
      if found_item == nil
        resp.status = 400
        resp.write "Item not found"
      else
        resp.status = 200
        resp.write found_item.price
      end
    end
    resp.finish
  end

 end
