proc top*[T](self: seq[T]): T = 
    self[self.len - 1]