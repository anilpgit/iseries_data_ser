**FREE
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
//*********************************************************************************
xml-into PersonDS %xml(xml_doc:'case=any doc=string path=people/person allowextra=yes allowmissing=yes datasubf=value'); ;
dsply PersonDS(1).Name.First_Name;
dsply PersonDS(2).Name.Last_Name;
Dsply ( %Char(xmlElements) + ' person records loaded.' ) ;
*inlr = *on;  
return;