dcl-f Person extname('Person') usage(*update) keyed;
dcl-c xml_doc '<People>'+
            '<Person><Name><First_Name>John</First_Name><Last_Name> Doe</LastName></Name><Age>30</Age></Person>' +
            '<Person><Name><First_Name>Jane</First_Name><Last_Name>Smith</LastName></Name><Age>25</Age></Person></People>';

dcl-s xml_doc_len int(10) inz(%len(%trim(xml_doc)));
dcl-s xml_doc_ptr pointer inz(%addr(xml_doc)); 
dcl-ds Name qualified;
  First_Name char(25);
  Last_Name char(25);
end-ds; 
dc-ds Person qualified;
    Name likeds(Name);
    Age int(3);
end-ds;