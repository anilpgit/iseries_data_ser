**FREE
dcl-f PERSON keyed usage(*input:*output:*update);

dcl-ds progStatus psds;
  xmlElements  Int(20) Pos(372);
end-ds;

// XML document to parse
dcl-c xml_doc '<people><person><name><first_name>John</first_name><last_name>Doe</last_name></name><age>30</age></person><person><name><first_name>Jane</first_name><last_name>Smith</last_name></name><age>25</age></person></people>';
dcl-c maxPersons 10;

dcl-s xml_doc_len int(10) inz(%len(%trim(xml_doc)));

dcl-ds NameDS qualified;
  First_Name char(25);
  Last_Name char(25);
end-ds;

dcl-ds PersonDS qualified dim(maxPersons);
  Name likeds(NameDS);
  Age int(3);
end-ds;

dcl-ds People qualified;
  Person likeds(PersonDS);
end-ds;

//*********************************************************************************
// Parse XML into PersonDS array
xml-into PersonDS %xml(xml_doc: 'case=any doc=string path=people/person allowextra=yes allowmissing=yes');

// Display first and second person's names
dsply ('First person first name: ' + %trim(PersonDS(1).Name.First_Name));
dsply ('Second person last name: ' + %trim(PersonDS(2).Name.Last_Name));

// Display number of person records loaded
dsply ( %char(xmlElements) + ' person records loaded.' );

*inlr = *on;
return;