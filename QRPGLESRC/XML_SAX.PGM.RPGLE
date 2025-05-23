**FREE
ctl-opt DFTACTGRP(*NO) ;
dcl-f PERSON keyed usage(*input:*output:*update);
dcl-f qsysprt printer(132) usage(*output) oflind(overflow);
Dcl-Ds progStatus psds;
  xmlElements  Int(20) Pos(372);
End-Ds;
dcl-c xml_doc '<people><person><name><first_name>John</first_name><last_name>Doe</last_name></name><age type="numeric">30</age></person><person><name><first_name>Jane</first_name><last_name>Smith</last_name></name><age type="numeric">25</age></person></people>';

dcl-s xml_doc_len int(10) inz(%len(%trim(xml_doc)));
//dcl-s xml_doc_ptr pointer inz(%addr(xml_doc)); 
dcl-ds NameDS qualified;
  First_Name char(25);
  Last_Name char(25);
end-ds; 

dcl-ds PersonDS qualified dim(10);
    Name likeds(NameDS);
    Age int(3);
end-ds;

dcl-ds People qualified;
  Person likeds(PersonDS); 
end-ds;

dcl-pr	xmlHandler int(10);
  ignore char(1);
  event  int(10) value;
  string  pointer value;
  length int(20) value;
  exceptionId int(10) value;
end-pr;

dcl-s xmlString char(100) ;
dcl-s ignoreMe char(1) inz('X');

dcl-ds PrintMe qualified;
  name char(21);
  data char(111);
end-ds;
 
dcl-pr XMLEvtName char(100);
  event int(10) value;
end-pr;
//************************************************************************************
xml-sax      %handler(xmlHandler: ignoreMe)
             %XML(xml_doc: 'doc=string');
eval *Inlr = *on;
//************************************************************************************
dcl-proc xmlHandler;
  dcl-pi        xmlHandler int(10);
  ignore      char(1);
  event       int(10) value;
  string      pointer value;
  Stringlen   int(20) value;
  exceptionId int(10) value;
  end-pi;

dcl-s value   char(65535) based(String);
dcl-s ucs2val char(16363) based(String);
dcl-s dspStr  char(52);
//************************************************************************************
PrintMe.name = XML_Event_Name(event);

PrintMe.data = *blanks;
 
       select;
       when string=*null or stringlen<1;
          // no string given...
       when stringlen>%size(value);
          PrintMe.data = '** string length invalid';
       other;
          PrintMe.data = %subst(value:1:stringlen);
       endsl;
 
       write QSYSPRT PrintMe;
return 0;
end-proc;

//************************************************************************************

dcl-proc       XML_Event_Name;
  dcl-pi       XML_Event_Name char(100);
    event      int(10) value;
  end-pi;

  dcl-s name   char(100);
  //************************************************************************************
  select;
       when event = *XML_START_DOCUMENT;
           return   'XML_START_DOCUMENT';
       when event = *XML_VERSION_INFO;
           return   'XML_VERSION_INFO';
       when event = *XML_ENCODING_DECL;
           return   'XML_ENCODING_DECL';
       when event = *XML_STANDALONE_DECL;
           return   'XML_STANDALONE_DECL';
       when event = *XML_DOCTYPE_DECL;
           return   'XML_DOCTYPE_DECL';
       when event = *XML_START_ELEMENT;
           return   'XML_START_ELEMENT';
       when event = *XML_CHARS;
           return   'XML_CHARS';
       when event = *XML_PREDEF_REF;
           return   'XML_PREDEF_REF';
       when event = *XML_UCS2_REF;
           return   'XML_UCS2_REF';
       when event = *XML_UNKNOWN_REF;
           return   'XML_UNKNOWN_REF';
       when event = *XML_END_ELEMENT;
           return   'XML_END_ELEMENT';
       when event = *XML_ATTR_NAME;
           return   'XML_ATTR_NAME';
       when event = *XML_ATTR_CHARS;
           return   'XML_ATTR_CHARS';
       when event = *XML_ATTR_PREDEF_REF;
           return   'XML_ATTR_PREDEF_REF';
       when event = *XML_ATTR_UCS2_REF;
           return   'XML_ATTR_UCS2_REF';
       when event = *XML_UNKNOWN_ATTR_REF;
           return   'XML_UNKNOWN_ATTR_REF';
       when event = *XML_END_ATTR;
           return   'XML_END_ATTR';
       when event = *XML_PI_TARGET;
           return   'XML_PI_TARGET';
       when event = *XML_PI_DATA;
           return   'XML_PI_DATA';
       when event = *XML_START_CDATA;
           return   'XML_START_CDATA';
       when event = *XML_END_CDATA;
           return   'XML_END_CDATA';
       when event = *XML_COMMENT;
           return   'XML_COMMENT';
       when event = *XML_EXCEPTION;
           return   'XML_EXCEPTION';
       when event = *XML_END_DOCUMENT;
           return   'XML_END_DOCUMENT';
       other;
           return   'UNKNOWN EVENT';
       endsl;

  return name;
end-proc;