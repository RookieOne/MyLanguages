    module SomeLanguageModule
    {
        import LanguageBaseModule { Common as C };

        @{CaseInsensitive}
        language RulesDefinition
        {
            // Delimiters
            @{Classification["Delimiter"]}
            token commandDelimiter = ";";

            token Command = c:(C.AlphaNum | "_")+;
           

            // The Program
            syntax Main
                = C.CommandList(Command, commandDelimiter);

            // Ignore whitespace
            interleave Whitespace = C.Whitespace | C.Comment | C.MultiLineComment;
        }
    }
