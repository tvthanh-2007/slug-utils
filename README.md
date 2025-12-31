# SlugUtils

`SlugUtils` is a Ruby module for generating clean, SEO-friendly slugs from multi-language text (Vietnamese, Japanese, Chinese, etc.).
It also provides a method to generate **unique slugs** to avoid duplicates.

---

## Installation

Add the gem via Git:

```ruby
gem "slug-utils", ~> "0.1.1"
```

Then run:

```bash
bundle install
```
---

## Usage

### Generate basic slug

**Default ASCII** (Latin only, accents removed):

```ruby
SlugUtils.generate("Học Ruby on Rails 2025!")
# => "hoc-ruby-on-rails-2025"
```

**Multi-language with Unicode** (keep accents):

```ruby
SlugUtils.generate("Bài viết mới 新しい記事", keep_accents: true)
# => "bài-viết-mới-新しい記事"
```

**Multi-language ASCII** (kanji/kana removed):

```ruby
SlugUtils.generate("Bài viết mới 新しい記事")
# => "bai-viet-moi"
```

---

### Generate unique slug

Automatically append `-1`, `-2`, … if the slug already exists:

```ruby
SlugUtils.generate_unique("Bài viết mới", existing: ["bai-viet-moi", "bai-viet-moi-1"])
# => "bai-viet-moi-2"
```

---

### Handling invalid input

```ruby
SlugUtils.generate(nil)
# => raise SlugUtils::InvalidText

SlugUtils.generate("   ")
# => raise SlugUtils::InvalidText
```

---

### Notes

* `keep_accents: true` → preserves all Unicode characters, including Latin letters with accents, kana, kanji, Chinese, Korean, etc.
* `keep_accents: false` → ASCII-friendly, only converts Latin letters (kana/kanji are removed if no external gem is used)
* `generate_unique` ensures the slug is unique when saving to the database or an array

---
