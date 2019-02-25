require 'elasticsearch/model'

class Note < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_many :comments
  has_many :sharenotes
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true

  acts_as_taggable_on :tags

  settings analysis: {
  filter: {
    ngram_filter: {
      type: "ngram",
      min_gram: "4",
      max_gram: "20"
    }
  },
  analyzer: {
    ngram_analyzer: {
      type: "custom",
      tokenizer: "standard",
      filter: ["lowercase", "ngram_filter"]
    }
  }
}do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: :english, analyzer: "ngram_analyzer"
      indexes :description, type: :text, analyzer: :english, analyzer: "ngram_analyzer"
      indexes :status, type: :boolean
      indexes :tag do
          indexes :id
          indexes :name
        end
    end
  end

  def self.search_published(query)
  self.search({
    query: {
      bool: {
        must: [
        {
          multi_match: {
            query: query,
            fields: [:title, :description],
            fuzziness: "AUTO"

          }
        },
        {
          match: {
            status: false
          }
        }]
      }
    }
  })
  end
end
Note.import(force: true)
