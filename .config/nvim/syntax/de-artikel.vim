if exists('b:current_syntax')
  finish
endif

syntax keyword deMaskulin Maskulin

syntax keyword deMaskulinartikel der den
syntax keyword deMaskulinartikel einen
syntax keyword deMaskulinartikel keinen

syntax keyword deMaskulinpossesivpronom meinen deinen seinen ihren unseren euren Ihren

syntax match deMaskulinsubstantiv  '^.\+, der\ze:'

syntax keyword deFeminin Feminin

syntax keyword deFemininartikel die
syntax keyword deFemininartikel eine einer
syntax keyword deFemininartikel keine keiner

syntax keyword deFemininpossesivpronom meine deine seine ihre unsere eure Ihre
syntax keyword deFemininpossesivpronom meiner deiner seiner ihrer unserer eurer Ihrer

syntax match deFemininsubstantiv '^.\+, die\ze:'

syntax keyword deNeutrum Neutrum

syntax keyword deNeutrumartikel das dem
syntax keyword deNeutrumartikel ein einem
syntax keyword deNeutrumartikel kein keinem

syntax keyword deNeutrumpossesivpronom mein dein sein ihr unser euer Ihr
syntax keyword deNeutrumpossesivpronom meinem deinem seinem ihrem unserem eurem Ihrem

syntax match deNeutrimsubstantiv '^.\+, das\ze:'

syntax keyword dePlural Plural

syntax keyword deCases Nominativ Akkusativ Dativ Genitiv

syntax match deComment '^# .*'
syntax match deQuote '(.\{-})'
syntax match deEnglish '".\{-}"'
syntax match deSection '\[.*\]'

syntax keyword deNumber null eins zwei drei vier fünf sechs sieben acht neun
syntax keyword deNumber zehn elf zwölf dreizehn vierzehn fünfzehn sechzehn siebzehn achtzehn neunzehn
syntax keyword deNumber zwanzig dreißig vierzig fünfzig sechzig siebzig achtzig neunzig
syntax keyword deNumber einhundert eintausend einmillion einmilliarde einbillion

syntax match deVerbReflexivEndung '^[^ ]\+\zsern\ze:'
syntax match deVerbRegularEndung '^[^ ]\+\zsen\ze:'
syntax match deVerbRadix '^[^ ]\+\ze\(en\|ern\):'

syntax match deNumber '\d\+\(e\d\+\)\?'

syntax match deNumericDigits '#\d\+'

let b:current_syntax = 'de-artikel'

highlight def link deMaskulin       Identifier
highlight def link deFeminin        Statement
highlight def link deNeutrum        PreProc
highlight def link dePlural         Special
highlight def link deCases          Type
highlight def link deComment        Comment
highlight def link deQuote          Special
highlight def link deEnglish        String
highlight def link deSection        Type
highlight def link deNumber         Constant
highlight def link deNumericDigits  Identifier

highlight def link deVerbRadix           Function

highlight def link deMaskulinartikel deMaskulin
highlight def link deFemininartikel  deFeminin
highlight def link deNeutrumartikel  deNeutrum

highlight def link deMaskulinpossesivpronom  deMaskulin
highlight def link deFemininpossesivpronom   deFeminin
highlight def link deNeutrumpossesivpronom   deNeutrum

highlight def link deMaskulinsubstantiv  deMaskulin
highlight def link deFemininsubstantiv   deFeminin
highlight def link deNeutrimsubstantiv   deNeutrum

