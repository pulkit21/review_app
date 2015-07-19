class Comment < ActiveRecord::Base
  belongs_to :merchant
  has_many :product_rating
  has_many :items, through: :product_rating
  validates :rating, :review, :site, :user_name, presence: true

  def text_processing(params)
    @response = RestClient.post "http://text-processing.com/api/sentiment/", { 'text' => params[:comment][:review] }, :accept => :json
    set_the_analysis_review(@response)
  end

  def set_the_analysis_review(response)
    @response = JSON.parse response
    self.negative_analysis = (@response["probability"]["neg"] * 100).round(0)
    self.positive_analysis = (@response["probability"]["pos"] * 100).round(0)
    self.neutral_analysis = (@response["probability"]["neutral"] * 100).round(0)
    self.analysis_label = @response["label"]
    self.semantics = @response["label"]
    self.save
  end
end
