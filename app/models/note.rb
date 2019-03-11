# frozen_string_literal: true

require 'elasticsearch/model'

# Note model for writng association.
class Note < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_many :comments, dependent: :destroy
  has_many :sharenotes, dependent: :destroy
  has_many :charges
  belongs_to :user
  # belongs_to :admin_user

  validates :title, presence: true
  validates :description, presence: true

  acts_as_taggable_on :tags

  settings analysis:
  {
    filter:
    {
      ngram_filter:
      {
        type: 'ngram',
        min_gram: '4',
        max_gram: '20'
      }
    },
    analyzer:
    {
      ngram_analyzer:
      {
        type: 'custom',
        tokenizer: 'standard',
        filter: %w[lowercase ngram_filter]
      }
    }
  } do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: 'ngram_analyzer'
      indexes :description, type: :text, analyzer: 'ngram_analyzer'
      indexes :status, type: :boolean
      indexes :tag do
        indexes :id
        indexes :name
      end
    end
  end

  def self.search_published(query)
    __elasticsearch__.search(
      query:
          {
            bool:
            {
              must:
              [
                {
                  multi_match:
                  {
                    query: query,
                    fields: %i[title description],
                    fuzziness: 'AUTO'
                  }
                },
                {
                  match:
                  {
                    status: false
                  }
                }
              ]
            }
          }
    )
  end

  def price_in_cents
    (price * 100).to_i
  end

end
Note.import
