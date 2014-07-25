class SymbolTable {
    private:
        Symbol* symbol_table;

    public:
        SymbolTable();
        bool add_symbol(Symbol* sym);
        bool add_symbol(char* name, char* type, char* scope);
}
