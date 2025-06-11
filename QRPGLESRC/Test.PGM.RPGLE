**FREE
ctl-opt dftactgrp(*no) actgrp(*caller);

dcl-pr XML_INTO extpgm('XML_INTO');
end-pr;

XML_INTO();

*inlr = *on;
return;