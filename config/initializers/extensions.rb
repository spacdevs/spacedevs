class Integer
  def to_mb
    (to_f / (1024 * 1024)).round(2)
  end
end
