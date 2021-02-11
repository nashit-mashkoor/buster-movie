# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    include ApplicationHelper
    before_action :set_user, only: %i[edit destroy update]
    before_action :authenticate_admin!

    def index
      @user_per_page = 10
      @users = User.page(params[:page]).per(@user_per_page)
    end

    def destroy
      if @user.destroy
        respond_to do |format|
        format.html { redirect_to admin_users_path, notice: 'User was successfully destroyed.'}
        format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to admin_users_path, alert: 'User was not destroyed.'}
          format.json { head :no_content }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, alert: 'User was not updated.' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :name, :email, :encrypted_password, :profile_pic)
    end

  end
end
