/*Autor: Leonardo de Souza Augusto - 278998 */

%{
#include "hash.h"
#include "y.tab.h"


int getLineNumber();
int isRunning();

int lineNumber = 1;
int running = 1;

%}

%x COMMENT

%%

cara                { return KW_CARA; }
inte                { return KW_INTE; }
real                { return KW_REAL; }
se                  { return KW_SE; }
entaum              { return KW_ENTAUM; }
senaum              { return KW_SENAUM; }
enquanto            { return KW_ENQUANTO; }
entrada             { return KW_ENTRADA; }
escreva             { return KW_ESCREVA; }
retorne             { return KW_RETORNE; }

"<="                { return OPERATOR_LE; }
">="                { return OPERATOR_GE; }
"=="                { return OPERATOR_EQ; }
"!="                { return OPERATOR_DIF; }

[-*.,;:{}()\[\]/<>=_+] { return yytext[0]; }
\"([^"\n]|\\\")+\"  { hashInsert(yytext, LIT_STRING); return LIT_STRING; }
[0-9]+              { hashInsert(yytext, LIT_INTEIRO); return LIT_INTEIRO; }
\'.\'               { hashInsert(yytext, LIT_CHAR); return LIT_CHAR; }
[a-z_-]+            { return TK_IDENTIFIER; }

\n                  { lineNumber++; }
[ \t]
\\\\.
\\\                 { BEGIN(COMMENT); }        
\"+                 { return TOKEN_ERROR; }
.                   { return TOKEN_ERROR; }             

<COMMENT>[///][//]   { BEGIN(INITIAL); }
<COMMENT>"\n"       { lineNumber++; }
<COMMENT>.          

%%
#include "y.tab.c"
#include "hash.c"
#include "main.c"

void initMe(){
    hashInit();
}

int getLineNumber () {
    return lineNumber;
}

int isRunning () {
    return running;
}

int yywrap() {
    running = 0;
    return 1;
}