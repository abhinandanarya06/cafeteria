class ReportsController < ApplicationController
  before_action :ensure_owner_or_clerk

  def index
    render "index"
  end
end
