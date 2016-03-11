class Article < ActiveRecord::Base
  attr_accessible :text, :title
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'text']
          }
        }
      }
    )
  end
end
Article.import
