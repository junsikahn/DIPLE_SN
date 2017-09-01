module ConvertHwp
  def self.convertHwp(hwp)
    latex = ' ' + hwp
    index = 0
    exec = /a/

    latex = latex.gsub(/([^a-zA-Z])not(\S*)/, "\\1 \\rlap{\\kern{0.1em}/}{\\2}")

    #rel 아직 지원안됨

    #BIGSQCAP BIGOMINUS BIGODIV UNDEROVER
    underover = [["sum ", "sum "], ["prod ", "prod "], ["coprod ", "coprod "],
    ["inter ", "bigcap "], ["union ", "bigcup "], ["BIGSQCUP ", "bigsqcup "], ["BIGOPLUS ", "bigoplus "],
    ["BIGOTIMES ", "bigotimes "], ["BIGODOT ", "bigodot "], ["BIGUPLUS ", "biguplus "],
    ["UNDEROVER {LOR }", "bigvee "], ["UNDEROVER {LAND }", "bigwedge "], ["BIGUPLUSE ", "biguplus"]]
    underover.each do |name|
      exec = latex =~ Regexp.new("([^\\\\a-zA-Z])"+name[0])
      while exec != nil do
        latex = latex[0..exec]+"{\\displaystyle\\"+name[1]+latex[(exec + $&.length)..(latex.length-1)]
        i = 0
        j = 15 + name[1].length
        k = 0
        check = 0
        while k < 2 do
          j = j + 1
          if latex[exec + j] == "{"
            i = i + 1
            check = 1
          elsif latex[exec + j] == "}"
            i = i - 1
          end
          if i == 0 && check == 1
            k = k + 1
            check = 0
          end
        end
        latex = latex[0..(exec + j)]+"}"+latex[(exec + j + 1)..(latex.length-1)]
        exec = latex =~ Regexp.new("([^\\\\a-zA-Z])"+name[0])
      end
    end

    exec = latex =~ /[^\\a-zA-Z]pile{/
    while exec != nil do
      latex = latex[0..exec]+"\\begin{aligned} "+latex[(exec + 6)..(latex.length-1)]
      i = 1
      j = 16
      while i > 0 do
        j = j + 1
        if latex[exec + j] == "{"
          i = i + 1
        elsif latex[exec + j] == "}"
          i = i - 1
        elsif latex[exec + j] == "#" && i == 1
          latex = latex[0..(exec + j - 1)]+" \\\\ "+latex[(exec + j + 1)..(latex.length - 1)]
          j += 3
        end
      end
      latex = latex[0..(exec + j - 1)]+" \\end{aligned}"+latex[(exec + j+1)..(latex.length - 1)]
      exec = latex =~ /[^\\a-zA-Z]pile{/
    end

    basic_func = ["det", "gcd", "max", "min", "Pr", "sin", "cos", "coth", "log",
    "tan", "cot", "ln", "lg", "sec", "cosec", "csc", "arcsin", "arccos", "arctan",
    "exp", "sinh", "cosh", "tanh", "hom", "ker", "deg", "arg", "dim"]
    basic_func.each do |name|
      latex = latex.gsub(Regexp.new("([^\\\\a-zA-Z])"+name), "\\1 \\"+name+" ")
    end

    greek = [["ALPHA", "A"], ["BETA", "B"], ["GAMMA", "\\Gamma"], ["DELTA", "\\Delta"],
    ["EPSILON", "E"], ["ZETA", "Z"], ["ETA", "H"], ["THETA", "\\Theta"], ["IOTA", "I"],
    ["KAPPA", "K"], ["LAMBDA", "\\Lambda"], ["MU", "M"], ["NU", "N"], ["XI", "\\Xi"],
    ["OMICRON", "O"], ["PI", "\\Pi"], ["RHO", "P"], ["SIGMA", "\\Sigma"], ["TAU", "T"],
    ["UPSILON", "Y"], ["PHI", "\\Phi"], ["CHI", "X"], ["PSI", "\\Psi"], ["OMEGA", "\\Omega"],
    ["alpha", "\\alpha"], ["beta", "\\beta"], ["gamma", "\\gamma"], ["delta", "\\delta"],
    ["epsilon", "\\epsilon"], ["zeta", "\\zeta"], ["eta", "\\eta"], ["theta", "\\theta"],
    ["iota", "\\iota"], ["kappa", "\\kappa"], ["lambda", "\\lambda"], ["mu", "\\mu"],
    ["nu", "\\nu"], ["xi", "\\xi"], ["omicron", "\\omicron"], ["pi", "\\pi"], ["rho", "\\rho"],
    ["sigma", "\\sigma"], ["tau", "\\tau"], ["upsilon", "\\upsilon"], ["phi", "\\phi"],
    ["chi", "\\chi"], ["psi", "\\psi"], ["omega", "\\omega"],
    ["ALEPH", "\\aleph"], ["hbar", "\\hbar"], ["imath", "\\imath"], ["jmath", "\\jmath"],
    ["LITER", "\\ell "], ["WP", "\\wp"], ["IMAG", "\\Im"],
    ["ANGSTROM", "\\rlap {\\kern{0.1em} {^{\\circ} \\atop {}}} {\\text{A}}"],
    ["vartheta", "\\vartheta"], ["varpi", "\\varpi"], ["varsigma", "\\varsigma"],
    ["varupsilon", "\\Upsilon"], ["varphi", "\\varphi"], ["varepsilon", "\\varepsilon"]]
    greek.each do |name|
      latex = latex.gsub(Regexp.new("([^\\\\a-zA-Z])"+name[0]), "\\1 "+name[1]+" ")
    end

    plusminus = [["-[+]", "\\mp"], ["TIMES", "\\times"], ["CIRC", "\\circ"], ["BULLET", "\\bullet"],
    ["DEG", "\\degree"], ["AST", "\\ast"], ["STAR", "\\star"], ["BIGCIRC", "\\bigcirc"],
    ["EMPTYSET", "\\emptyset"], ["THEREFORE", "\\therefore"], ["BECAUSE", "\\because"],
    ["IDENTICAL", "{\\large ::}"], ["EXIST", "\\exists"], ["!=", "\\neq"], ["DOTEQ", "\\doteq"],
    ["image", "\\fallingdotseq"], ["REIMAGE", "\\risingdotseq"], ["SIM", "\\thicksim"],
    ["APPROX", "\\thickapprox"], ["SIMEQ", "\\simeq"], ["CONG", "\\cong"], ["==", "\\equiv"],
    ["ASYMP", "\\asymp"], ["ISO", "\\Bumpeq"], ["DIAMOND", "\\diamond"], ["DSUM", "\\dotplus"],
    ["FORALL", "\\forall"], ["prime", "\\prime"], ["Partial", "\\partial"], ["INF", "\\infty"],
    ["LNOT", "\\lnot"], ["PROPTO", "\\propto"], ["XOR", "\\veebar"], ["NABLA", "\\nabla"],
    ["DAGGER", "\\dagger"], ["DDAGGER", "\\ddagger"]]
    plusminus.each do |name|
      latex = latex.gsub(Regexp.new("([^\\\\a-zA-Z])"+name[0]), "\\1 "+name[1]+" ")
    end

    relation = [["SMALLSUM", "{\\footnotesize\\sum}"], ["SMALLPROD", "{\\footnotesize\\prod}"],
    ["SMCOPROD", "\\amalg"], ["SMALLINTER", "{\\large\\cap}"], ["CUP", "{\\large\\cup}"],
    ["SQCAP", "{\\large\\sqcap}"], ["SQCUP", "{\\large\\bigsqcup}"], ["OPLUS", "{\\large\\oplus}"],
    ["OMINUS", "{\\large\\ominus}"], ["OTIMES", "{\\large\\otimes}"], ["ODIV", "{\\large\\ospash}"],
    ["ODOT", "{\\large\\odot}"], ["LOR", "\\lor"], ["LAND", "\\land"], ["SUBSET", "\\subset"],
    ["SUPERSET", "\\supset"], ["SUBSETEQ", "\\subseteq"], ["SUPSETEQ", "\\supseteq"], ["IN", "\\in"],
    ["OWNS", "\\owns"], ["NOTIN", "\\notin"], ["LEQ", "\\leq"], ["GEQ", "\\geq"], ["SQSUBSET", "\\sqsubset"],
    ["SQSUBSETEQ", "\\sqsubseteq"], ["<<<", "\\lll"], [">>>", "\\ggg"], ["<<", "\\ll"],
    [">>", "\\gg"], ["PREC", "{\\large\\prec}"], ["SUCC", "{\\large\\succ}"], ["UPLUS", "{\\large\\uplus}"]]
    relation.each do |name|
      latex = latex.gsub(Regexp.new("([^\\\\a-zA-Z])"+name[0]), "\\1 "+name[1]+" ")
    end

    #OVERBRACE, UNDERBRACE
    arrow = [["larrow", "leftarrow"], ["<->", "leftrightarrow"], ["->", "rightarrow"], ["uparrow", "uparrow"],
    ["downarrow", "downarrow"], ["LARROW", "Leftarrow"], ["RARROW", "Rightarrow"], ["UPARROW", "Uparrow"],
    ["DOWNARROW", "Downarrow"], ["udarrow", "updownarrow"], ["UDARROW", "Updownarrow"],
    ["LRARROW", "Leftrightarrow"], ["NWARROW", "nwarrow"], ["SEARROW", "searrow"], ["NEARROW", "nearrow"],
    ["SWARROW", "swarrow"], ["HOOKLEFT", "hookleftarrow"], ["HOOKRIGHT", "hookrightarrow"],
    ["MAPSTO", "mapsto"], ["DLINE", "Vert"], ["vert", "vert"],
    ["LCEIL", "lceil"], ["RCEIL", "rceil"], ["LFLOOR", "lfloor"], ["RFLOOR", "rfloor"]]
    arrow.each do |name|
      latex = latex.gsub(Regexp.new("([^\\\\a-zA-Z])"+name[0]), "\\1 \\"+name[1]+" ")
    end

    vector = [["vec", "stackrel{\\longrightarrow}"], ["dyad", "stackrel{\\longleftrightarrow}"],
    ["acute", "acute"], ["grave", "grave"], ["dot", "dot"], ["ddot", "ddot"], ["hat", "hat"],
    ["under", "underline"], ["bar", "overline"], ["tilde", "tilde"], ["check", "check"], ["arch", "stackrel{\\frown}"]]
    vector.each do |name|
      latex = latex.gsub(Regexp.new("{"+name[0]+"{"), "{\\"+name[1]+"{")
    end

    #BOX
    latex = latex.gsub(/{BOX{/, " \\color{blue}{\\underline{")

    geek = [["mod", "bmod"], ["Exp", "text{Exp}"], ["arc", "text{arc}"],
    ["if", "text{if}"], ["for", "text{for}"], ["and", "text{and}"]]
    geek.each do |name|
      latex = latex.gsub(Regexp.new("([^\\\\a-zA-Z])"+name[0]), "\\1 \\"+name[1]+" ")
    end

    #RTANGLE, ATT, HUND, THOU, WELL, BASE, BENZENE, LAPLACE, CENTIGRADE, FAHRENHEIT
    etc = [["CDOTS", "cdots"], ["CDOT", "cdot"], ["LDOTS", "ldots"], ["VDOTS", "vdots"], ["DDOTS", "ddots"],
    ["TRIANGLE", "triangle"], ["NABLA", "triangledown"], ["ANGLE", "angle"], ["MSANGLE", "measuredangle"],
    ["SANGLE", "sphericalangle"], ["VDASH", "vdash"], ["DASHV", "dashv"], ["BOT", "bot"],
    ["TOP", "top"], ["MODELS", "models"], ["LSLANT", "diagup"], ["RSLANT", "diagdown"]]
    etc.each do |name|
      latex = latex.gsub(Regexp.new("([^\\\\a-zA-Z])"+name[0]), "\\1 \\"+name[1]+" ")
    end

    latex = latex.gsub(/([^\\a-zA-Z])TIMES/,"\\1 \\times ")

    #oiint, oiiint
    latex = latex.gsub(/([^\\a-zA-Z])int /,"\\1 \\int ")
    latex = latex.gsub(/([^\\a-zA-Z])dint /,"\\1 \\iint ")
    latex = latex.gsub(/([^\\a-zA-Z])tint /,"\\1 \\iiint ")
    latex = latex.gsub(/([^\\a-zA-Z])oint /,"\\1 \\oint ")

    latex = latex.gsub(/([^\\a-zA-Z])LEFT {/,"\\1 \\left \\{")
    latex = latex.gsub(/([^\\a-zA-Z])RIGHT {/,"\\1 \\right \\{")
    latex = latex.gsub(/([^\\a-zA-Z])bigg {/,"\\1 \\Bigg \\{")
    latex = latex.gsub(/([^\\a-zA-Z])LEFT }/,"\\1 \\left \\}")
    latex = latex.gsub(/([^\\a-zA-Z])RIGHT }/,"\\1 \\right \\}")
    latex = latex.gsub(/([^\\a-zA-Z])bigg }/,"\\1 \\Bigg \\}")
    latex = latex.gsub(/([^\\a-zA-Z])LEFT /,"\\1 \\left ")
    latex = latex.gsub(/([^\\a-zA-Z])RIGHT /,"\\1 \\right ")
    latex = latex.gsub(/([^\\a-zA-Z])bigg /,"\\1 \\Bigg ")

    latex = latex.gsub(/([^\\a-zA-Z])[lL]im /,"\\1 \\lim\\limits ")


    index = latex.index("} over ")
    while index != nil do
      latex = latex.sub("} over ", "} ")
      i = 1
      j = 0
      while i > 0 do
        j = j + 1
        if latex[index - j] == "}"
          i = i + 1
        elsif latex[index - j] == "{"
          i = i - 1
        end
      end
      latex = latex[0..(index - j - 1)]+" \\dfrac "+latex[(index - j)..(latex.length - 1)]
      index = latex.index("} over ")
    end

    matrix = [["{cases{", "{\\begin{cases} ", " \\end{cases}",],
    ["{matrix{", "{\\begin{matrix} ", " \\end{matrix}"], ["{pmatrix{", "{\\begin{pmatrix} ", " \\end{pmatrix}"],
    ["{dmatrix{", "{\\begin{vmatrix} ", " \\end{vmatrix}"], ["{bmatrix{", "{\\begin{bmatrix} ", " \\end{bmatrix}"]]
    matrix.each do |name|
      index = latex.index(name[0])
      while index != nil do
        latex = latex.gsub(name[0], name[1])
        i = 1
        j = name[1].length - 1
        while i > 0 do
          j = j + 1
          if latex[index + j] == "{"
            i = i + 1
          elsif latex[index + j] == "}"
            i = i - 1
          elsif latex[index + j] == "#" && i == 1
            latex = latex[0..(index + j - 1)]+" \\\\ "+latex[(index + j + 1)..(latex.length - 1)]
            j += 3
          end
        end
        latex = latex[0..(index + j - 1)]+name[2]+latex[(index + j + 1)..(latex.length - 1)]
        index = latex.index(name[0])
      end
    end

    index = latex.index(" atop ")
    while index != nil do
      latex = latex.gsub(" atop ", " \\atop ")
      i = 1
      j = 7
      while i > 0 do
        j = j + 1
        if latex[index + j] == "{"
          i = i + 1
        elsif latex[index + j] == "}"
          i = i - 1
        end
      end
      latex = latex[0..(index + j)]+"}"+latex[(index + j + 1)..(latex.length - 1)]
      i = j = 1
      while i > 0 do
        j = j + 1
        if latex[index - j] == "}"
          i = i + 1
        elsif latex[index - j] == "{"
          i = i - 1
        end
      end
      latex = latex[0..(index - j - 1)]+"{"+latex[(index - j)..(latex.length - 1)]

      index = latex.index(" atop ")
    end

    latex = latex.gsub(/([^a-zA-Z\\])sqrt /,"\\1 \\sqrt ")

    exec = latex =~ /[^\\a-zA-Z]root /
    while exec != nil do
      latex = latex[0..exec]+"\\sqrt ["+latex[(exec + 6)..(latex.length - 1)]
      i = 1
      j = 0
      while i > 0 do
        j = j + 1
        if latex[exec + j + 8] == "}"
          i = i - 1
        elsif latex[exec + j + 8] == "{"
          i = i + 1
        end
      end
      latex = latex[0..(exec + j + 8)]+"]"+latex[(exec + j + 12)..(latex.length - 1)]
      exec = latex =~ /[^\\a-zA-Z]root /
    end

    latex = latex.gsub(/([가-힣]+)/," \\text{\\1} ")

    rm_filter = /\\?[a-zA-Z]+/
    rm_checks = []
    rm_on = false
    already_text = false

    matchArray = latex =~ rm_filter
    before_length = 0
    while matchArray != nil do
      matchArray = matchArray + before_length
      if $& == "rm"
        rm_on = true
      elsif $& == "it"
        rm_on = false
      elsif $& == "\\text"
        already_text = true
      elsif $&[0] != "\\"
        if already_text == true
          already_text = false
        elsif rm_on == true
          rm_checks << [matchArray, $&.length]
        end
      end
      before_length = before_length + $`.length + $&.length
      matchArray = $' =~ rm_filter
    end
    rm_checks.each_with_index do |rm_check, f_index|
      latex = latex[0..(rm_check[0] + f_index*7 - 1)] + "\\text{" + latex[(rm_check[0] + f_index*7)..(rm_check[0] + rm_check[1]+f_index*7 - 1)] + "}" + latex[(rm_check[0] + rm_check[1] + f_index*7)..(latex.length - 1)]
    end

    latex = latex.gsub(/([^\\a-zA-Z])rm/,"\\1")
    latex = latex.gsub(/([^\\a-zA-Z])it/,"\\1")

    #####################특수문자 대응####################
    # #, &, "", \, ≪, ⋘
    diff_name = [["~", "enspace"], ["`", "kern{0.125 em}"], ["±", "pm"], ["÷", "div"], ["△", "triangle"],
    ["Ω", "Omega"], ["⊐", "sqsupset"], ["⊒", "sqsupseteq"], ["∥", "Vert"], ["°", "degree"], ["", "vert"], ["", "vert"], ["", "vert"], ["%", "%"]]
    diff_name.each do |name|
      latex = latex.gsub(Regexp.new(name[0]), " \\"+name[1]+" ")
    end

    latex = latex.gsub(/[ ]+/, " ")
    if latex[0] == " "
      latex = latex[1..(latex.length - 1)]
    end
    if latex[latex.length-1] == " "
      latex = latex[0..(latex.length-2)]
    end

    return latex
  end


  def self.read_file(file_name)
    doc = Nokogiri::XML(File.open(file_name + ".xml"))
    units = []
    text = ""
    bindata = []

    doc.css("HEADER").each do |p|
      new_node = doc.create_element "CHARandSCRIPT"
      new_node.content = ""
      p.replace new_node
    end

    doc.css("FOOTER").each do |p|
      new_node = doc.create_element "CHARandSCRIPT"
      new_node.content = ""
      p.replace new_node
    end

    doc.css("SCRIPT").each do |script|
      tmp = convertHwp(script.text)
      tmp = tmp.gsub("&", "&gt;")
      tmp = tmp.gsub("<", "&lt;")
      tmp = tmp.gsub(">", "&gt;")
      new_node = doc.create_element "CHARandSCRIPT"
      new_node.content = "$" + tmp + "$"
      script.replace new_node
    end

    doc.css("CHAR").each do |char|
      tmp = char.text
      tmp = tmp.gsub("&", "&gt;")
      tmp = tmp.gsub("<", "&lt;")
      tmp = tmp.gsub(">", "&gt;")
      new_node = doc.create_element "CHARandSCRIPT"
      new_node.content = tmp
      char.replace new_node
    end

    doc.css("P").each do |p|
      new_node = doc.create_element "CHARandSCRIPT"
      new_node.content = "\n"
      if p["PageBreak"] == "true"
        new_node["PageBreak"] = "true"
      end
      p << new_node
    end

    doc.css("RECTANGLE").each do |rectangle|
      if rectangle.css("LINESHAPE")[0]["Style"] != nil && rectangle.css("LINESHAPE")[0]["Style"] != "None"
        tmp = ""
        rectangle.css("CHARandSCRIPT").each do |t|
          tmp += t.text
        end
        new_node = doc.create_element "CHARandSCRIPT"
        new_node.content = "\n<div class='ui segment'>\n" + toHTML(tmp) + "</div>\n"
        rectangle.replace new_node
      end
    end

    convertTable(doc, doc)

    doc.css("BINDATA").each do |bin|
      bindata << bin.content
    end

    doc.css("PICTURE").each do |pic|
      new_node = doc.create_element "CHARandSCRIPT"
      width = pic.css("SIZE")[0]["Width"].to_f / 75
      if pic.css("POSITION")[0]["TreatAsChar"] == "true" || pic.css("SHAPEOBJECT")[0]["TextWrap"] == "TopAndBottom"
        new_node.content = "<div style='display: inline-block;width: " + width.to_s + "px;margin: 0 auto; max-width: 100%;'><img src='data:image/png;base64," +
                          #bindata[pic.css("IMAGE")[0]["BinItem"].to_i - 1] +
                          "'><br></div>"
      elsif pic.css("SHAPEOBJECT")[0]["TextFlow"] == "RightOnly" || pic.css("SHAPEOBJECT")[0]["TextFlow"] == "LargestOnly" || pic.css("SHAPEOBJECT")[0]["TextFlow"] == "BothSides"
        new_node.content = "<div style='float: right;width: " + width.to_s + "px;margin: 0 auto; max-width: 100%;'><img src='data:image/png;base64," +
                          #bindata[pic.css("IMAGE")[0]["BinItem"].to_i - 1] +
                          "'><br></div>"
      elsif pic.css("SHAPEOBJECT")[0]["TextFlow"] == "LeftOnly"
        new_node.content = "<div style='float: left;width: " + width.to_s + "px;margin: 0 auto; max-width: 100%;'><img src='data:image/png;base64," +
                          #bindata[pic.css("IMAGE")[0]["BinItem"].to_i - 1] +
                          "'><br></div>"
      end
      pic.replace new_node
    end

    doc.css("CHARandSCRIPT").each do |t|
      if t["PageBreak"] == "true"
        units << text
        text = ""
      else
        text += t.text
      end
    end
    units << text



    units.each_with_index do |unit, index|
      answer = 0
      answer_set = []
      question = ""
      unit = unit.gsub(/\n[ ]+/, "\n")
      unit = unit.gsub("$$", "$ $")
      unit = unit.gsub(/\n[①②③④⑤]\n/, "\n")
      split_1 = unit.split("[정답]")
      split_2 = split_1[1].split("[배점]")
      split_3 = split_2[1].split("[문항코드]")
      split_4 = split_3[1].split("[분류체계]")
      split_5 = split_4[1].split("[해설]")

      if split_2[0] =~ /[①②③④⑤]/
        if $& == "①"
          answer = 1
        elsif $& == "②"
          answer = 2
        elsif $& == "③"
          answer = 3
        elsif $& == "④"
          answer = 4
        elsif $& == "⑤"
          answer = 5
        end
        tmp_set = split_1[0].split("\n")
        answer_set = tmp_set[(tmp_set.length-5)..(tmp_set.length-1)]
        for i in 0..(tmp_set.length-6) do
          question = question + tmp_set[i] + "\n"
        end
      else
        question = split_1[0]
        split_2[0] =~ /[0-9]+/
        answer = $&.to_i
      end

      split_3[0] =~ /[0-9]+/
      score = $&.to_i

      units[index] = {content: toHTML(question), exm: answer_set, answer: answer, score: score, explanation: toHTML(split_5[1])}
    end

    return units
  end

  def self.convertTable(doc, table_node)
    table = table_node.css("TABLE").first
    while table != nil do
      convertTable(doc, table)
      tmp = ""
      check = false
      width = table.css("SIZE")[0]["Width"].to_f / 75
      if table.css("POSITION")[0]["TreatAsChar"] == "true" || table.css("SHAPEOBJECT")[0]["TextWrap"] == "TopAndBottom"
        tmp += "<div style='display: inline-block;width: " + width.to_s + "px;margin: 0 auto; max-width: 100%;'>"
      elsif table.css("SHAPEOBJECT")[0]["TextFlow"] == "RightOnly" || table.css("SHAPEOBJECT")[0]["TextFlow"] == "LargestOnly" || table.css("SHAPEOBJECT")[0]["TextFlow"] == "BothSides"
        tmp += "<div style='float: right;width: " + width.to_s + "px;margin: 0 auto; max-width: 100%;'>"
      elsif table.css("SHAPEOBJECT")[0]["TextFlow"] == "LeftOnly"
        tmp += "<div style='float: left;width: " + width.to_s + "px;margin: 0 auto; max-width: 100%;'>"
      end
      if table.css("CELL").count == 1
        table.css("CHARandSCRIPT").each do |t|
          tmp += t.text
        end
        new_node = doc.create_element "CHARandSCRIPT"
        new_node.content = "\n<div class='ui segment'>\n" + toHTML(tmp) + "</div>\n"
        table.replace new_node
      else
        tmp += "<table class='ui table center aligned'>"
        count = 0
        table.css("ROW").each do |row|
          if count == 0
            tmp += "<thead>"
          elsif count == 1
            tmp += "<tbody>"
            count = 2
          end
          tmp += "<tr>"
          row.css("CELL").each do |cell|
            tmp2 = ""
            cell.css("CHARandSCRIPT").each do |t|
              if t.text =~ /[①②③④⑤]/
                check = true
              end
              tmp2 += t.text
            end
            tmp += "<th>" + toHTML(tmp2) + "</th>"
          end
          tmp += "</tr>"
          if count == 0
            tmp += "</thead>"
            count = 1
          end
        end

        if check == false
          new_node = doc.create_element "CHARandSCRIPT"
          new_node.content = tmp + "</tbody></table></div>"
          table.replace new_node
        else
          new_node = doc.create_element "CHARandSCRIPT"
          new_node.content = ""
          table.replace new_node
        end
      end
      table = table_node.css("TABLE").first
    end
  end

  def self.toHTML(text)
    html = ""
    text.each_line do |line|
      if line.start_with?("<")
        html = html + line + "\n"
      else
        html = html + "<div>" + line +  "</div>\n"
      end
    end

    html = html.gsub("<div>\n</div>", "<div><br></div>")
    html = html.gsub("\n</div>", "</div>")

    return html
  end
end
