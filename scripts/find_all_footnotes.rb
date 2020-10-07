fnt = V2Web::Text.all.select {|t| t.content_content =~ /<sup>/};
fntsects = fnt.map { |f| f.parent };
