# coding: utf-8
class TargetsController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @targets = Target.where( user_id: session[:user_id] ).all
  end

  #------#
  # show #
  #------#
  def show
    @target = Target.where( id: params[:id], user_id: session[:user_id] ).first
  end

  #-----#
  # new #
  #-----#
  def new
    @target = Target.new
  end

  #------#
  # edit #
  #------#
  def edit
    @target = Target.where( id: params[:id], user_id: session[:user_id] ).first
  end

  #--------#
  # create #
  #--------#
  def create
    @target = Target.new( params[:target] )
    @target.user_id = session[:user_id]

    if @target.save
      redirect_to( { action: "index" }, notice: "Target was successfully created." )
    else
      render action: "new"
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @target = Target.where( id: params[:id], user_id: session[:user_id] ).first

    if @target.update_attributes( params[:target] )
      redirect_to( { action: "show", id: params[:id] }, notice: "Target was successfully updated." )
    else
      render action: "edit", id: params[:id]
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @target = Target.where( id: params[:id], user_id: session[:user_id] ).first
    @target.destroy

    redirect_to action: "index"
  end

end
