**FREE
dcl-f PERSON keyed usage(*input:*output:*update);
dcl-c xml_doc '<People><Person><Name><First_Name>John</First_Name><Last_Name>Doe</Last_Name></Name><Age>30</Age></Person><Person><Name><First_Name>Jane</First_Name><Last_Name>Smith</Last_Name></Name><Age>25</Age></Person></People>';

dcl-s xml_doc_len int(10) inz(%len(%trim(xml_doc)));
//dcl-s xml_doc_ptr pointer inz(%addr(xml_doc)); 
dcl-ds NameDS qualified;
  First_Name char(25);
  Last_Name char(25);
end-ds; 
dcl-ds PersonDS qualified;
    Name likeds(NameDS);
    Age int(3);
end-ds;

xml-into PersonDS %xml(xml_doc:'case=any') ;
dsply PersonDS;
*inlr = *on;  
return;