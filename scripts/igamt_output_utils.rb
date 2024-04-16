def keyify(vocab)
  output = {}
  vocab.each do |v|
    output[v['bindingIdentifier']] = v
  end
  output
end
