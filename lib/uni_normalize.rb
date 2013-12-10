
def uni_normalize uname
  return nil if uname.blank?
  uname.downcase.gsub ' ', ''
end

