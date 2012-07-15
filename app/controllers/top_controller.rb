# coding: utf-8
class TopController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    Target.heroku_periodic_access( url_for(:root) )
  end

end
