class FeeCategoriesController < ApplicationController
	  # GET /fees/new
  def new
    @fee_category = FeeCategory.new
  end
end
