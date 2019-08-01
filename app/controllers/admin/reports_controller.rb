# frozen_string_literal: true

module Admin
  class ReportsController < ApplicationController
    include ApplicationHelper
    before_action :set_report, only: [:destroy]
    before_action :authenticate_admin!, except: [:create]

    def index
      @reports_per_page = 10
      @reports = Report.includes(:review).page(params[:page]).per(@reports_per_page)
    end

    def create
      @report = Report.new(user_id: report_params[:user_id],
                           review_id: report_params[:review_id])
      respond_to do |format|
        if @report.save
          flash.now[:notice] = 'Report has been filed'
          format.js
        else
          format.html { redirect_to request.referer, alert: 'Report creation failed'}
        end
      end
    end

    # if user chooses to ignore a report
    def destroy
      @report.destroy
      respond_to do |format|
        format.html { redirect_to admin_reports_url, notice: 'Report was successfully destroyed. Review has been approved'}
        format.json { head :no_content }
        format.js
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.permit(:id, :user_id, :review_id)
    end
  end
end
