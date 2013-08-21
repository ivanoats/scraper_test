desc "scape google and put results into db"
task :scrape => :environment do
  puts "I'm scraping!"

  Capybara.run_server = false
  Capybara.current_driver = :webkit
  Capybara.app_host = "http://www.google.com/"

  module Test
    class Google
      include Capybara::DSL

      def get_results
        visit('/')
        fill_in "q", :with => "Capybara"
        click_button "Google Search"
        all(:xpath, "//li[@class='g']/h3/a").each do |a|
          Search.create(result: a[:href])
        end
      end

    end
  end

  spider = Test::Google.new
  spider.get_results

  Search.all.each do |search|
    puts search.result
  end

  puts "Done scraping"
end
