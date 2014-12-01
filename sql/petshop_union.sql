SELECT dogs.name as pet_name, petshops.name  
      FROM dogs  
      JOIN petshops  
      ON dogs.shop_id = petshops.id 
      UNION  
      SELECT cats.name pet_name, petshops.name  
      FROM cats  
      JOIN petshops  
      ON cats.shop_id = petshops.id 
      order by pet_name