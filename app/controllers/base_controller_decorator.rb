Spree::BaseController.class_eval do
  after_filter :save_search

  def save_search
    keywords = @searcher.try!(:keywords)


    if keywords.present? && @products
      query = Spree::Suggestion.find_or_initialize_by(keywords: keywords)
      query.items_found = @products.size
      query.increment(:count)
      query.save
    end
  end
end
