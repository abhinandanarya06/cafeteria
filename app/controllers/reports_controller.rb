class ReportsController < ApplicationController
  before_action :ensure_owner

  def index
    render "index"
  end
end
