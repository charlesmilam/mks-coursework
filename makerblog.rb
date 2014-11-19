require 'rest_client'
require "json"
require "time"

# response = RestClient.get('http://makerblog.herokuapp.com/posts', accept: 'application/json')

# posts = JSON.parse(response.body)

module MakerBlog
  class Client
    def list_posts
      response = RestClient.get('http://makerblog.herokuapp.com/posts', accept: 'application/json')
      posts = JSON.parse(response.body)
      posts.each do |post|
        # your code goes here!
        puts post
      end
    end

    def show_post(id)
        # hint: URLs are strings and you'll need to append the ID
        url = "http://makerblog.herokuapp.com/posts/#{id}"

        response = RestClient.get(url, accept: 'application/json')
        puts response
    end

    def create_post(name, title, content)
      url = "http://makerblog.herokuapp.com/posts/" # you know where to send this, right? (the same url we've been POSTing to)
      payload = {:post => {'name' => name, 'title' => title, 'content' => content}}

      response = RestClient.post(url, JSON.generate(payload), accept: 'application/json', content_type: 'application/json')

      post = JSON.parse(response.body)

      # convert then display your results here
      pretty = ("Post successfuly created:\n
                    Post id: #{post["id"]}\n
                    Creator: #{post["name"]}\n
                    Post Title: #{post["title"]}\n
                    Post Content: #{post["content"]}\n
                    Post Create Date: #{Time.parse(post["created_at"])}")

    end

    def edit_post(id, options = {})
      url = "http://makerblog.herokuapp.com/posts/#{id}" # same as show post above, seeing the pattern yet?
      params = {}

      # can't figure this part out? Google "ruby options hash"
      params[:name] = options[:name] unless options[:name].nil?
      params[:title] = options[:title] unless options[:title].nil?
      params[:content] = options[:content] unless options[:content].nil?

      response = RestClient.put(url, { post: params }, accept: 'application/json', content_type: 'application/json')

      # you know the drill, convert the response and display the result nicely
      post = JSON.parse(response)
      # # convert then display your results here
      pretty = ("Post successfuly updated:\n
                    Post id: #{post["id"]}\n
                    Creator: #{post["name"]}\n
                    Post Title: #{post["title"]}\n
                    Post Content: #{post["content"]}\n
                    Post Update Date: #{Time.parse(post["created_at"])}")

    end

    def delete_post(id)
      url = "http://makerblog.herokuapp.com/posts/#{id}" # this should be familiar by now
      response = RestClient.delete(url, accept: 'application/json')
      puts response.code
end
  end
end

blog = MakerBlog::Client.new

blog.list_posts
blog.show_post("19685")
puts blog.create_post("Scruffy Bitwrangler", "Test Post", "This is a test post. And only a test post.")
puts blog.edit_post("19829", {:name => "Scruffy Bitwrangler", :title => "Test Post Edited", :content => "This is a test post. And only a test post. Yes, there are a bunch of them."})

blog.delete_post("19842")



