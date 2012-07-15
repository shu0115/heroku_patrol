# coding: utf-8
class Target < ActiveRecord::Base
  attr_accessible :name, :url, :user_id

  private

  #-----------------------------#
  # self.heroku_periodic_access #
  #-----------------------------#
  # Heroku定期アクセス
  $timer_arry = Array.new

  def self.heroku_periodic_access( root_url )
    $timer_arry.each{ |timer|
      # タイマーキャンセル
      result = timer.cancel

      # タイマー削除
      if result == true
        $timer_arry.delete( timer )
      end
    }

    EM.run do
#      targets = Target.where( user_id: session[:user_id] ).order( "name ASC" ).all
      targets = Target.order( "name ASC" ).all
      my_host = URI.parse( root_url ).host

      targets.each { |target|
        if target.url.index( my_host ).nil?
          # 1分周期
          result = EM.add_periodic_timer( 10 ) do
            url = target.url
            parsed_url = URI.parse( url )
            http = Net::HTTP.new( parsed_url.host, parsed_url.port )

            if url.index("https:") == 0
              http.use_ssl = true
              http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            end

            request = Net::HTTP::Get.new( parsed_url.request_uri )
            response = http.request( request )

            print "[ #{Time.now.strftime("%Y/%m/%d %H:%M:%S")} #{target.name} ] : " ; p response ;
          end

          # タイマー保管
          $timer_arry.push( result )
        end
      }
    end
  end
end
