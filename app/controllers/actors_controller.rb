# frozen_string_literal: true

class ActorsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_admin!
  before_action :set_actor, only: %i[show edit update destroy]

  # GET /actors
  # GET /actors.json
  def index
    @actor_per_page = 10
    @actors = Actor.page(params[:page]).per(@actor_per_page)
  end

  # GET /actors/new
  def new
    @actor = Actor.new
  end

  # GET /actors/1/edit
  def edit; end

  # POST /actors
  # POST /actors.json
  def create
    @actor = Actor.new(actor_params)
    respond_to do |format|
      if @actor.save
        format.html { redirect_to edit_actor_path(@actor), notice: 'Actor was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /actors/1
  # PATCH/PUT /actors/1.json
  def update
    respond_to do |format|
      if @actor.update(actor_params)
        format.html { redirect_to edit_actor_path(@actor), notice: 'Actor was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @actor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actors/1
  # DELETE /actors/1.json
  def destroy
    @actor.destroy
    respond_to do |format|
      format.html { redirect_to actors_url, notice: 'Actor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_actor
    @actor = Actor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def actor_params
    params.require(:actor).permit(:name, :actor_pic)
  end
end
