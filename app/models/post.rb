class Post < ActiveRecord::Base
  
    validates :title, presence: true
    validates :summary, length: {maximum: 250}
    validates :content, length: {minimum: 250}
    validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
    validate :is_clickbait?

    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,
        /Secret/i,
        /Top [0-9]*/i,
        /Guess/i]

    def is_clickbait?
        if CLICKBAIT_PATTERNS.none? {|p| p.match title}
            errors.add(:title, 'must be clickbait')
        end
    end
end
