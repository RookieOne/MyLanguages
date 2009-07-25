module UiLanguage
{
    import LanguageBaseModule { Common as c};
    
    language UiLanguage
    {
        interleave Ignore=c.Whitespace;
    
        syntax Main = v:ViewSetup+ => ViewCompilation {v};
    
        syntax ViewSetup = b:ModelBinding 
            t:SetTitle? c.NewLine?
            c:CommandBind* 
            
         => {View{b}, Titled{t}, Commands{valuesof(c)}};
        
        // Model Binding 
        syntax ModelBinding = viewBind v:ViewModel c.NewLine? => Bind {v};        
        syntax ViewModel = v:variable => v;
        @{ Classification["Keyword"]} 
        token viewBind = "View for ";
        
        // Set Title        
        syntax SetTitle = titled s:quotedSentence => s;
        @{ Classification["Keyword"]} 
        token titled = "Titled";
        
        // Command Binding
        syntax CommandBind = can v:variable c.NewLine? => v;
        @{ Classification["Keyword"]} 
        token can = "Can";
        
        
        syntax quotedSentence = a:'"' t:sentence b:'"' => t;
        syntax sentence = t:word* => t;
        
        token variable = c.Letter c.AlphaNum+;
        token word = c.AlphaNum+ | c.Whitespace;
        token sentenceFrag = word (c.Whitespace word)*;
        //token sentenceFrag = word (c.Whitespace word)*;
    }
}


















module LanguageBaseModule
    {
        export Common;

        language Common
        {
            token Letter = "a".."z" | "A".."Z";
            token Digit = "0".."9";
            token AlphaNum = Letter | Digit;

            @{Classification["Number"]}
            token Number = Digit+;
            // New line
            token LF = "\u000A";
            token CR = "\u000D";

            token NewLine
                = LF
                | CR
                | CR LF
            ;

            // Whitespace
            @{Classification["Whitespace"]}
            token Whitespace = WhitespaceCharacter+;

            token Space = "\u0020";
            token Tab = '\u0009';
            token WhitespaceCharacter
                = Tab   // Horizontal Tab
                | Space // Space
                | NewLine
            ;
            // Comments       
            token CommentDelimitedContent =
                ^('*')
                | '*'  ^('/');
                
            @{Classification["Comment"]}
            token Comment = "//" ^("\r" | "\n")+;
            @{Classification["Comment"]}
            token MultiLineComment = "/*" CommentDelimitedContent* "*/";

            // Commands list
            syntax CommandList(cmd, commandDelimiter)
                = c:cmd commandDelimiter => [c]
                | c:cmd commandDelimiter l:CommandList(cmd, commandDelimiter) => [c, valuesof(l)];
        }
    }