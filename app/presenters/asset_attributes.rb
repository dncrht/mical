AssetAttributes = Struct.new(:asset) do
  def call(delete_url)
    {
      src: asset.image.thumb('320x240#').url,
      href: asset.image.remote_url,
      deleteUrl: delete_url
    }
  end
end
