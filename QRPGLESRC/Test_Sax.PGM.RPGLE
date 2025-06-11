**FREE
ctl-opt dftactgrp(*no) actgrp(*caller);

dcl-pr XML_SAX extpgm('XML_SAX');
end-pr;

XML_SAX();

*inlr = *on;
return;