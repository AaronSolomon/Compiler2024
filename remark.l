%x REMARK

%%
"/*"            { BEGIN REMARK; }
<REMARK>"*/"    { BEGIN INITIAL; }
<REMARK>.|\n    { }
%%
