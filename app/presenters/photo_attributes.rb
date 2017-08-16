PhotoAttributes = Struct.new(:photo) do
  def call(delete_url)
    {
      src: photo.image.thumb('320x240#').url,
      href: photo.image.remote_url,
      deleteUrl: delete_url
    }
  end
end
