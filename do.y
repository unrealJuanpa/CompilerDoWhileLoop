%{
    #include <stdio.h>
    #include <string.h>

    char codigotres[1024] = "";
    int ctemp = 1;
    int cop = 0;
    int actual = 1;

    char tempcad1[500] = "";
    char tempcad2[500] = "";
    char tempcad3[500] = "";
    char tempcad4[500] = "";
    char tempcad5[500] = "";
    char tempcad6[500] = "";
    char tempcad7[500] = "";

    void yyerror(char *mensaje);
    void nuevaTemp(char *s);
    int yylex();

    // strcpy($$, ""); strcat($$, $1); strcat($$, $2); printf("Sintaxis correcta!, contenido: %s\n", $$);
%}

%union{
    char cadena[50];
}



%token <cadena>WHILEPALABRA
%token <cadena>DOPALABRA
%token <cadena>UNOOMASESP
%token <cadena>IDENTIFICADOR
%token <cadena>ENTERO
%token <cadena>IGUAL
%token <cadena>LLAVEI
%token <cadena>LLAVEF
%token <cadena>PUNTOYCOMA
%token <cadena>SIGNOMAS
%token <cadena>SIGNOMENOS
%token <cadena>SIGNOMULT
%token <cadena>SIGNODIV
%token <cadena>MENOR
%token <cadena>MAYOR
%token <cadena>EOL
%token <cadena>PARENTESISI
%token <cadena>PARENTESISF

%type <cadena> inicio
%type <cadena> identifoint
%type <cadena> operacion

%%
inicio      : dowhile           { printf("\n\nSintaxis correcta!\n"); return 0; }
            ;

ceroomaseol : EOL ceroomaseol
            |
            ;

ceroomasesp : UNOOMASESP
            |
            ;

identifoint : IDENTIFICADOR
            | ENTERO
            ;

operacion   : operacion ceroomasesp SIGNOMAS ceroomasesp identifoint { nuevaTemp($$); printf("\t%s=%s+%s;\n",$$,$1,$5); }
            | operacion ceroomasesp SIGNOMENOS ceroomasesp identifoint { nuevaTemp($$); printf("\t%s=%s-%s;\n",$$,$1,$5);  }
            | operacion ceroomasesp SIGNOMULT ceroomasesp identifoint { nuevaTemp($$); printf("\t%s=%s*%s;\n",$$,$1,$5);  }
            | operacion ceroomasesp SIGNODIV ceroomasesp identifoint { nuevaTemp($$); printf("\t%s=%s/%s;\n",$$,$1,$5);  }
            | identifoint                                           {  }
            ; 

asignacion  : IDENTIFICADOR ceroomasesp IGUAL ceroomasesp operacion PUNTOYCOMA  { printf("\t%s=#%s%i;\n", $1, "t", actual-1); }
            | IDENTIFICADOR ceroomasesp SIGNOMAS SIGNOMAS ceroomasesp PUNTOYCOMA { printf("\t%s=%s+1;\n", $1, $1); } 
            ; 

comparacion : PARENTESISI ceroomasesp identifoint ceroomasesp MAYOR ceroomasesp identifoint ceroomasesp PARENTESISF { printf("\tifZ %s > %s goto #l1", $3, $7); }
            | PARENTESISI ceroomasesp identifoint ceroomasesp MENOR ceroomasesp identifoint ceroomasesp PARENTESISF { printf("\tifZ %s < %s goto #l1", $3, $7); }
            ;

sentencia   : ceroomaseol ceroomasesp asignacion sentencia
            | ceroomaseol ceroomasesp
            ;

bloquewhile : ceroomaseol ceroomasesp WHILEPALABRA ceroomasesp comparacion PUNTOYCOMA
            ;

iniciowhile : DOPALABRA { printf("#l1: "); }
            ;

dowhile     : ceroomaseol ceroomasesp iniciowhile ceroomasesp LLAVEI sentencia LLAVEF bloquewhile ceroomaseol

%%

void nuevaTemp(char *s) {
    sprintf(s, "#t%d", actual++);
} 

void yyerror(char *mensaje) {
    fprintf(stderr, "\n\nError de sintaxis\n");
}

int main() {
    yyparse();

    //printf("\n\n----- Codigo de tres vias generado -----\n");
    //printf(codigotres);

    return 0;
}
