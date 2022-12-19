%token KW_CARA           
%token KW_INTE            
%token KW_REAL          

%token KW_SE             
%token KW_ENTAUM           
%token KW_SENAUM           
%token KW_ENQUANTO          
%token KW_ENTRADA           
%token KW_ESCREVA          
%token KW_RETORNE        

%token OPERATOR_LE       
%token OPERATOR_GE       
%token OPERATOR_EQ       
%token OPERATOR_DIF      

%token TK_IDENTIFIER     

%token LIT_INTEIRO
%token LIT_FLOAT       
%token LIT_CHAR          
%token LIT_STRING        

%token TOKEN_ERROR      

%left OPERATOR_LE OPERATOR_GE OPERATOR_EQ OPERATOR_DIF '<' '>' 
%left '+' '-'
%left '*' '/'

%{

int yyerror();

%}

%%

program: decl
    ;

decl: 
      dec remainder
    | decfunc remainderfunc
    |
    ;

remainder: 
      ';' decl
    ;
remainderfunc: 
      decl
    ;

decfunc:  
      KW_INTE TK_IDENTIFIER '(' arglist ')' cmd
    | KW_CARA TK_IDENTIFIER '(' arglist ')' cmd
    | KW_REAL TK_IDENTIFIER '(' arglist ')' cmd
    ;

arglist: 
      arg remainder_args
    | arg
    |
    ;

remainder_args:
      ',' arg remainder_args
    | ',' arg
    ;

arg: 
      KW_INTE TK_IDENTIFIER
    | KW_CARA TK_IDENTIFIER
    | KW_REAL TK_IDENTIFIER
    ;

dec:  KW_INTE TK_IDENTIFIER decintchar
    | KW_INTE TK_IDENTIFIER '.' TK_IDENTIFIER decintchar
    | KW_CARA TK_IDENTIFIER decintchar
    | KW_REAL TK_IDENTIFIER decfloat
    ;


decintchar: 
      '=' LIT_INTEIRO 
    | '=' LIT_CHAR
    | array
    ;

decfloat: 
      '=' LIT_INTEIRO '.' LIT_INTEIRO
    | array
    ;

array:
      '[' LIT_INTEIRO ']' LIT_INTEIRO array_values
    | '[' LIT_INTEIRO ']' LIT_CHAR array_values
    | '[' LIT_INTEIRO ']'
    ;

array_values: 
      LIT_INTEIRO array_values
    | LIT_CHAR array_values
    |
    ;

lcmd: 
      cmd ';' lcmd
    | label lcmd
    |
    ;

label:
      TK_IDENTIFIER '='
    ;

cmd: 
      '{' lcmd '}'
    | TK_IDENTIFIER '=' expr
    | TK_IDENTIFIER '[' expr ']' '=' expr
    | KW_ESCREVA printargs
    | KW_ENQUANTO expr cmd
    | KW_ENTAUM expr KW_SE cmd if_body
    | KW_RETORNE expr
    | 
    ;

if_body:
      KW_SE cmd
    |
    ;

expr: 
      LIT_INTEIRO
    | LIT_CHAR
    | TK_IDENTIFIER '[' expr ']'
    | TK_IDENTIFIER '(' exprlist')'
    | TK_IDENTIFIER
    | KW_ESCREVA
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | expr '<' expr
    | expr '>' expr
    | expr OPERATOR_DIF expr
    | expr OPERATOR_EQ expr
    | expr OPERATOR_GE expr
    | expr OPERATOR_LE expr
    | '(' expr ')'
    ;

exprlist:
      expr ',' exprlist
    | expr
    ;

printargs:
      printarg ',' printargs
    | printarg
    ;

printarg:
      LIT_STRING
    | expr
    ;





%%

int yyerror (){
    printf("Syntax Error at line %d\n", getLineNumber());
    exit(3);
}