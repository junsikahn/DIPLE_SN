class ProblemImage < ActiveRecord::Base
  belongs_to :problem, optional: true

  before_destroy :image_clear

  has_attached_file :image,
                    styles: { original: { geometry: '500>x', format: :png } },
                    url: '/assets/problems/images/:id_partition.:extension',
                    path: ':rails_root/public/assets/problems/images/:id_partition.:extension',
                    default_url: '/images/card_image_preview.png'
  validates_attachment :image,
                       presence: true,
                       size: { less_than: 20.megabytes },
                       content_type: { content_type: ['image/jpeg', 'image/pjpeg', 'image/png', 'image/jpg', 'image/gif'] }

  def image_url
    image.url
  end

  def image_clear
    image.clear
  end
end
