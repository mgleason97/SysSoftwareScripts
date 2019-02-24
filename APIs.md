# APIs
You can find all of the functions and structs listed in each of the support
files listed below

## ast

### ast.c

    void printIndent(FILE *fp, int depth) {}
    void printstring(FILE *fp, char *string, int depth) {}
    void printbool(FILE *fp, bool value, int depth) {}
    void printint(FILE *fp, int value, int depth) {}
    void printToken(FILE *fp, struct Token *token, int depth) {}
    void printDataType(FILE *fp, struct DataType *datatype, int depth) {}
    void printScope(FILE *fp, struct Scope *scope, int depth) {}
    void printSymbol(FILE *fp, struct Symbol *symbol, int depth) {}
    void printstringTyped(FILE *fp, char *string, int depth) {}
    void printboolTyped(FILE *fp, bool value, int depth) {}
    void printintTyped(FILE *fp, int value, int depth) {}
    void printTokenTyped(FILE *fp, struct Token *token, int depth) {}
    void printDataTypeTyped(FILE *fp, struct DataType *datatype, int depth) {}
    void printScopeTyped(FILE *fp, struct Scope *scope, int depth) {}
    void printSymbolTyped(FILE *fp, struct Symbol *symbol, int depth) {}
    struct TranslationUnit *newTranslationUnit() {}
    struct Block *newBlock() {}
    struct FuncDecl *newFuncDecl() {}
    struct TypedIdent *newTypedIdent() {}
    struct TypedIdentList *newTypedIdentList() {}
    struct TypedIdentListElement *newTypedIdentListElement() {}
    void addTypedIdent(struct TypedIdentList *list, struct TypedIdent *node) {}
    struct FuncDeclList *newFuncDeclList() {}
    struct FuncDeclListElement *newFuncDeclListElement() {}
    void addFuncDecl(struct FuncDeclList *list, struct FuncDecl *node) {}
    struct Statement *newStatement(enum statement_union kind) {}
    struct StatementList *newStatementList() {}
    struct StatementListElement *newStatementListElement() {}
    void addStatement(struct StatementList *list, struct Statement *node) {}
    struct Expression *newExpression(enum expression_union kind) {}
    struct ExpressionList *newExpressionList() {}
    struct ExpressionListElement *newExpressionListElement() {}
    void addExpression(struct ExpressionList *list, struct Expression *node) {}
    void printTranslationUnit(FILE *fp, struct TranslationUnit *node, int depth) {}
    void printTranslationUnitTyped(FILE *fp, struct TranslationUnit *node, int depth) {}
    void printBlock(FILE *fp, struct Block *node, int depth) {}
    void printBlockTyped(FILE *fp, struct Block *node, int depth) {}
    void printFuncDecl(FILE *fp, struct FuncDecl *node, int depth) {}
    void printFuncDeclTyped(FILE *fp, struct FuncDecl *node, int depth) {}
    void printTypedIdent(FILE *fp, struct TypedIdent *node, int depth) {}
    void printTypedIdentTyped(FILE *fp, struct TypedIdent *node, int depth) {}
    void printTypedIdentList(FILE *fp, struct TypedIdentList *list, int depth) {}
    void printTypedIdentListTyped(FILE *fp, struct TypedIdentList *list, int depth) {}
    void printFuncDeclList(FILE *fp, struct FuncDeclList *list, int depth) {}
    void printFuncDeclListTyped(FILE *fp, struct FuncDeclList *list, int depth) {}
    void printStatement(FILE *fp, struct Statement *node, int depth) {}
    void printStatementTyped(FILE *fp, struct Statement *node, int depth) {}
    void printStatementList(FILE *fp, struct StatementList *list, int depth) {}
    void printStatementListTyped(FILE *fp, struct StatementList *list, int depth) {}
    void printExpression(FILE *fp, struct Expression *node, int depth) {}
    void printExpressionTyped(FILE *fp, struct Expression *node, int depth) {}
    void printExpressionList(FILE *fp, struct ExpressionList *list, int depth) {}
    void printExpressionListTyped(FILE *fp, struct ExpressionList *list, int depth) {}
    
### ast.h

    struct Translation Unit {};
    struct FuncDecl {};
    struct TypedIdent {};
    struct TypedIdentList {};
    struct TypedIdentListElement {};
    struct FuncDeclList {};
    struct FuncDeclListElement {};
    enum statement_union {};
    struct Statement {};
    struct StatementList {};
    struct StatementListElement {};
    enum expression_union {};
    struct Expression {};
    struct ExpressionList {};
    struct ExpressionListElement {};


## datatype

### datatype.c

    struct DataType *getInt() {}
    struct DataType *getBool() {}
    struct DataType *getVoid() {}
    struct DataType *getPrimitiveType(struct TypedIdent *typedident) {}
    struct DataType *getFuncType(struct FuncDecl *funcdecl) {}
    bool isPrimitiveType(struct DataType *datatype) {}
    bool isFuncType(struct DataType *datatype) {}
    bool isInt(struct DataType *datatype) {}
    bool isBool(struct DataType *datatype) {}
    bool isVoid(struct DataType *datatype) {}
    bool equalTypes(struct DataType *a, struct DataType *b) {}
    void print_data_type(FILE *fp, struct DataType *datatype) {}

### datatype.h

    enum primitive_type {};
    struct TupleElement {};
    enum datatype_kind {};
    struct DataType {};
    

## parser

### parser.c

    struct TranslationUnit* parser(struct Token** token_list_in) {}
    static struct TranslationUnit *program() {}
    static struct Block *block() {}
    static struct TypedIdentList *vardecls() {}
    static struct FuncDeclList *funcdecls() {}
    static struct TypedIdentList *formals() {}
    static struct Token *type() {}
    static struct Statement *statement() {}
    static struct ExpressionList *exprlist() {}
    static struct Expression *expr() {}
    bool static is_relop() {}
    static struct Expression *simpleexpr() {}
    bool static is_termop() {}
    static struct  Expression *term() {}
    bool static is_factorop() {}
    static struct  Expression *factor() {}

### parser_tools.c

    static void next() {}
    static void previous() {}
    static struct Token *token() {}
    static void parse_error() {}
    static bool is_token(enum tok_kind kind) {}
    static bool lookahead_token(enum tok_kind kind) {}
    static bool ensure_token(enum tok_kind kind) {}


## symtab

### symtab.c

    struct Scope *addScope(char *name, struct Scope *parent) {}
    struct Scope *getParentScope(struct Scope *scope) {}
    struct Symbol *addVariable(struct Scope *scope, char *name, struct TypedIdent *node) {}
    struct Symbol *addFunction(struct Scope *scope, char *name, struct FuncDecl *node) {}
    static struct Symbol *addSymbol(struct Scope *scope, char *name, struct Symbol *symbol) {}
    struct Symbol *getSymbol(struct Scope *scope, char *name) {}
    struct Symbol *searchSymbol(struct Scope *scope, char *name) {}
    void print_space(FILE *fp, int depth) {}
    void print_scope(FILE *fp, struct Scope *scope, int depth) {}

### symtab.h

    struct Symbol {};
    struct SymbolList {};
    struct SymbolListElement {};
    struct Scope {};
    struct ScopeList {};
    struct ScopeListElement {};


## token

### token.c

    struct Token* new_identifier(int kind, char *lexeme) {}
    struct Token* new_number(int kind, int number) {}
    struct Token* new_token(int kind) {}
    struct Token *alloc_token() {}
    struct Token** alloc_token_list() {}
    void print_token_kind(FILE *fp, enum tok_kind kind) {}
    void print_token(FILE *fp, struct Token *token) {}
    void write_tokens(FILE *fp, struct Token **list) {}

### token.h

    enum tok_kind {};
    struct Token {};


## typechecker

### typechecker.c

    static void visitTranslationUnit(struct TranslationUnit *node) {}
    static void visitBlock(struct Block *node) {}
    static void visitVarDecl(struct TypedIdent *node) {}
    static void visitVarDecls(struct TypedIdentList *list) {}
    static void visitFuncDecl(struct FuncDecl *node) {}
    static void visitFormal(struct TypedIdent *node) {}
    static void visitFormals(struct TypedIdentList *list) {}
    static void visitFuncDeclList(struct FuncDeclList *list) {}
    static void visitStatement(struct Statement *node) {}
    static void visitAssignStatement(struct Statement *node) {}
    static void visitCallStatement(struct Statement *node) {}
    static void visitReturnStatement(struct Statement *node) {}
    static void visitCompoundStatement(struct Statement *list) {}
    static void visitIfStatement(struct Statement *node) {}
    static void visitWhileStatement(struct Statement *node) {}
    static void visitReadStatement(struct Statement *node) {}
    static void visitWriteStatement(struct Statement *node) {}
    static void visitExpressionList(struct ExpressionList *list) {}
    static void visitExpression(struct Expression *node) {}
    static void visitBinaryExpression(struct Expression *node) {}
    static void visitUnaryExpression(struct Expression *node) {}
    static void visitNumberFactor(struct Expression *node) {}
    static void visitBooleanFactor(struct Expression *node) {}
    static void visitVariableFactor(struct Expression *node) {}
    static void visitFunctionFactor(struct Expression *node) {}

### typechecker_tools.c

    void print_symtab(FILE *fp) {}
    void type_error(char *msg) {}

