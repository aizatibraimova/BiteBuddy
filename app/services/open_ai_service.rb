class OpenAiService
  def initialize(api_key)
    @client = OpenAI::Client.new(api_key: api_key)
  end

  def analyze_data(meals, allergies)
    prompt = <<-PROMPT
    Analyze the following data for potential allergens and patterns where allergies occur after meals:

    Meals:
    #{meals.to_json}

    Allergies:
    #{allergies.to_json}

    Highlight any food items that are repeatedly followed by allergy symptoms.
    PROMPT

    response = @client.completions(
      engine: "text-davinci-003",
      prompt: prompt,
      max_tokens: 500,
    )

    response["choices"].first["text"].strip
  end
end
