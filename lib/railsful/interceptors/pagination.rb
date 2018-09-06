# frozen_string_literal: true

module Railsful
  module Interceptors
    # Interceptor that paginates a given ActiveRecord::Relation
    # with help of the Kaminari gem.
    module Pagination
      def render(options)
        super(pagination_options(options))
      end

      def pagination_options(options)
        # Check if json value should be paginated.
        return options unless paginate?(options)

        # Get the relation from options hash so we can paginate it and
        # check the total count.
        relation = options.fetch(:json)

        # Paginate the relation and store new relation in temporary variable.
        paginated = paginate(relation)

        # Create a meta hash
        meta = {
          total_pages: paginated.try(:total_pages),
          total_count: paginated.try(:total_count)
        }

        options.deeper_merge(
          links: links(paginated), meta: meta
        ).merge(json: paginated)
      end

      private

      # Check if given entity is paginatable and request allows pagination.
      #
      # @param options [Hash] The global render options.
      # @return [Boolean] The answer.
      def paginate?(options)
        params[:page] &&
          method == 'GET' &&
          relation?(options)
      end

      # Paginate given relation
      #
      # @param relation [ActiveRecord::Relation] The relation.
      # @return [ActiveRecord::Relation] The paginated relation.
      def paginate(relation)
        per_page = params[:per_page]

        relation = relation.page(params.fetch(:page))
        relation = relation.per(per_page) if per_page

        relation
      end

      # Create the pagination links
      #
      # @param relation [ActiveRecord::Relation] The relation to be paginated.
      # @param per_page [Integer] The number of records per page.
      # @return [Hash] The +links+ hash.
      def links(relation)
        per_page = params[:per_page]

        {
          self: collection_url(relation.try(:current_page), per_page),
          next: collection_url(relation.try(:next_page), per_page),
          prev: collection_url(relation.try(:prev_page), per_page)
        }
      end

      # The assembled pagination url.
      #
      # @param per_page [Integer] The per page count.
      # @param page [Integer] The page.
      # @return [String] The URL.
      def collection_url(page, per_page)
        return nil unless page

        # The +#url_for+ method comes from the given controller.
        controller.url_for \
          controller: params[:controller],
          action: params[:action],
          params: {
            page: page,
            per_page: per_page
          }.compact
      end
    end
  end
end