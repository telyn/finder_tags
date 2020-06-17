class FinderTags
  module Titlecase
    refine String do
      def titlecase
        self[0].upcase + self[1, length]
      end
    end
  end
end
