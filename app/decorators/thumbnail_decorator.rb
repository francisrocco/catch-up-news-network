class ThumbnailDecorator < SimpleDelegator

  def post_title
    # makes one less request than using thumbnail.title
    title = self.title unless @thumbnail.title
    title = @thumbnail.title
    if title.length < 60
      return title
    else
      return title[0..57] + "..."
    end
  end

  def description
    # makes one less request than using thumbnail.description
    desc = @thumbnail.description
    if desc.length < 110
      return desc
    else
      return desc[0..107] + "..."
    end
  end


  def image
    # doesn't work with @thumbnail.images
    image = thumbnail.images.first.src.to_s
  end
end