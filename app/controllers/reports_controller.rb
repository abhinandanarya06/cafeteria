class ReportsController < ApplicationController
  before_action :ensure_owner_or_clerk

  def index
    idate = params[:idate]
    fdate = params[:fdate]
    begin
      idate = DateTime.parse(idate)
      fdate = DateTime.parse(fdate)
    rescue
      idate = nil
      fdate = nil
    end
    render "index", locals: { idate: idate, fdate: fdate }
  end
end
