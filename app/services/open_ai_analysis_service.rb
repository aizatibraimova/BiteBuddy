# app/services/open_ai_analysis_service.rb
require 'openai'

class OpenAiAnalysisService
  def initialize(meals, allergies)
    @meals = meals
    @allergies = allergies
    @prompt = construct_prompt
  end

  def analyze
    access_token = ENV['OPENAI_ACCESS_TOKEN']
    Rails.logger.debug("OpenAI access token: #{access_token}")

    if access_token.nil?
      Rails.logger.error("OpenAI access token is missing from environment variables")
      raise "OpenAI access token is missing from environment variables"
    end

    client = OpenAI::Client.new(access_token: access_token)

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: @prompt }],
        max_tokens: 500
      }
    )

    Rails.logger.debug("OpenAI response: #{response}")

    result_text = response.dig("choices", 0, "message", "content")
    parse_result(result_text)
  rescue Faraday::ClientError => e
    handle_errors(e)
  end

  private

  def construct_prompt
    prompt = "Analyze the following data for potential allergens and patterns where allergies occur after meals:\n\n"
    prompt += "Meals:\n"
    prompt += @meals.map { |meal| "#{meal.date}: #{meal.food.name}" }.join("\n")
    prompt += "\n\nAllergies:\n"
    prompt += @allergies.map { |allergy| "#{allergy.detected_date}: #{allergy.description}" }.join("\n")
    prompt += "\n\nHighlight any food items that are repeatedly followed by allergy symptoms."
    prompt
  end

  def parse_result(result_text)
    findings = result_text.split("\n\n").first
    recommendations = result_text.split("\n\n").last

    { findings: findings, recommendations: recommendations }
  end

  def handle_errors(error)
    Rails.logger.error("OpenAI API Error: #{error.message}")
    { findings: "An error occurred", recommendations: "Please try again later" }
  end
end
