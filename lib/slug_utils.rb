# frozen_string_literal: true

require_relative "slug_utils/version"

module SlugUtils
  class Error < StandardError; end
  class InvalidText < Error; end

  def self.generate(text, keep_accents: false)
    raise InvalidText, "Text cannot be blank" if text.nil? || text.strip.empty?

    slug = text.strip.downcase

    if keep_accents
      slug.gsub!(/[^\p{L}\p{N}]+/u, "-")
    else
      slug = slug.unicode_normalize(:nfkd).encode("ASCII", replace: "")
      slug.gsub!(/[^a-z0-9]+/, "-")
    end

    slug.gsub!(/^-+|-+$/, "")
    slug
  end

  def self.generate_unique(text, existing: [], keep_accents: false)
    base_slug = generate(text, keep_accents:)
    slug = base_slug
    counter = 1

    while existing.include?(slug)
      slug = "#{base_slug}-#{counter}"
      counter += 1
    end

    slug
  end
end
