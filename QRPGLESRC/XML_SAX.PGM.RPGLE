**FREE
ctl-opt DFTACTGRP(*NO) ;
dcl-f PERSON keyed usage(*input:*output:*update);
Dcl-Ds progStatus psds;
  xmlElements  Int(20) Pos(372);
End-Ds;
dcl-c xml_doc '<people><person><name><first_name>John</first_name><last_name>Doe</last_name></name><age>30</age></person><person><name><first_name>Jane</first_name><last_name>Smith</last_name></name><age>25</age></person></people>';

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
  name char(100);
  data char(100);
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
  length      int(20) value;
  exceptionId int(10) value;
  end-pi;

//************************************************************************************
PrintMe.name = XML_Event_Name(event);
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
    when event = *xml_start_element;
      name = 'Start Element';
    when event = *xml_end_element;
      name = 'End Element';
    
    when event = *xml_comment;
      name = 'Comment';
   
    when event = *xml_start_document;
      name = 'Start Document';
    when event = *xml_end_document;
      name = 'End Document';
    
    other;
      name = 'Unknown Event';
  endsl;

  return name;
end-proc;