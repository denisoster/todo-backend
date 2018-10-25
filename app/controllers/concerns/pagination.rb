module Pagination
  extend ActiveSupport::Concern

  include Pagy::Backend

  def pagination_params
    @items = params[:items] || 10
    @page = params[:page] || 1
    @outset = params[:outset] || 0
  end

  def pagination_options(pagy)
    options = {}
    options[:is_collection] = true
    options[:meta] = pagination_attributes(pagy)
    options
  end

  private

  def pagination_attributes(pagy)
    { count: pagy.count,
      items: pagy.items,
      pages: pagy.pages,
      next: pagy.next,
      self: pagy.page,
      prev: pagy.prev,
      last: pagy.last }
  end
end
