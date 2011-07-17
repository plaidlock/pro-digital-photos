products = Page.create!(title:'Products')
  prints_and_finishing = products.children.create!(title:'Prints & Finishing')
    prints_and_finishing.children.create!(title:'Photographic Prints')
    finishing_services = prints_and_finishing.children.create!(title:'Finishing Services')
      finishing_services.children.create!(title:'Mounting')
      finishing_services.children.create!(title:'Texture & Coating')
    prints_and_finishing.children.create!(title:'Standout')
    prints_and_finishing.children.create!(title:'Framed Prints')
  
  press_printed = products.children.create!(title:'Press Printed Cards & Products')
    press_printed.children.create!(title:'Boutique Cards')
    press_printed.children.create!(title:'Greeting Cards')
    press_printed.children.create!(title:'Postcards')
    press_printed.children.create!(title:'Business Cards')
    

about_us = Page.create!(title:'About Us')
  about_us.children.create!(title:'Environmental Responsibility')
  about_us.children.create!(title:'Company History')
  about_us.children.create!(title:'Production Facilities')
  about_us.children.create!(title:'Our Staff')
  about_us.children.create!(title:'Customer Service')

pro = Page.create!(title:'Go Pro', right_nav:true)