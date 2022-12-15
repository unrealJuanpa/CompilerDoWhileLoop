%option noyywrap
%{
    #include "do.tab.h"    
%}

%% 
"while"                     { strcpy(yylval.cadena,yytext); return WHILEPALABRA;    }
"do"                        { strcpy(yylval.cadena,yytext); return DOPALABRA;       }
[a-zA-Z]([a-zA-Z]|[0-9])*   { strcpy(yylval.cadena,yytext); return IDENTIFICADOR;   }
[0-9]+                      { strcpy(yylval.cadena,yytext); return ENTERO;          }
"="                         { strcpy(yylval.cadena,yytext); return IGUAL;           }
" "+                        { strcpy(yylval.cadena,yytext); return UNOOMASESP;      }
"{"                         { strcpy(yylval.cadena,yytext); return LLAVEI;          }
"}"                         { strcpy(yylval.cadena,yytext); return LLAVEF;          }
"("                         { strcpy(yylval.cadena,yytext); return PARENTESISI;     }
")"                         { strcpy(yylval.cadena,yytext); return PARENTESISF;     } 
";"                         { strcpy(yylval.cadena,yytext); return PUNTOYCOMA;      }
"+"                         { strcpy(yylval.cadena,yytext); return SIGNOMAS;        }
"-"                         { strcpy(yylval.cadena,yytext); return SIGNOMENOS;      }
"*"                         { strcpy(yylval.cadena,yytext); return SIGNOMULT;       }
"/"                         { strcpy(yylval.cadena,yytext); return SIGNODIV;        }
"<"                         { strcpy(yylval.cadena,yytext); return MENOR;           }
">"                         { strcpy(yylval.cadena,yytext); return MAYOR;           }
\n+                          { strcpy(yylval.cadena,yytext); return EOL;             }
.                           {  }

%%
