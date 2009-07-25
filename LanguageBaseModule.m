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
            token Tab = ‘\u0009′;
            token WhitespaceCharacter
                = Tab   // Horizontal Tab
                | Space // Space
                | NewLine
            ;
            // Comments       
            token CommentDelimitedContent =
                ^(’*')
                | ‘*’  ^(’/')
            ;
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
