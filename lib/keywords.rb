class Keywords
  require 'sanitize'
  COMMON_WORDS = ["a", "about", "after", "all", "alos", "are", "an", "and", "any", "as", "at", "back", "be", "because", "but", "by", "can", "come", "could", "day", "do", "even", "first", "for", "from", "get", "give", "go", "good", "have", "he", "her", "him", "his", "how", "i", "if", "in", "into", "it", "its", "just", "know", "like", "look", "make", "me", "most", "my", "new", "no", "not", "now", "of", "on", "one", "only", "or", "other", "our", "out", "over", "person", "say", "see", "she", "so", "some", "take", "than", "that", "the", "their", "them", "then", "there", "these", "they", "think", "this", "time", "to", "two", "up", "us", "use", "want", "way", "we", "well", "what", "when", "which", "who", "will", "with", "work", "would", "year", "you", "your", "is"]

  class << self
    def generate(text)
      freqs = Hash.new(0)
      text = Sanitize.clean(text) # remove all HTML tags
      words = text.split(/\s/)
      words.each do |w|
        word = w.downcase.gsub(/[^a-z]/, '').strip
        freqs[word] += 1 unless word.blank? || Keywords::COMMON_WORDS.include?(word)
      end
      keywords = freqs.sort_by{|k,v| v}.reverse![0..10].collect{|a| a.first}.join(', ')

      return keywords
    end
  end
end