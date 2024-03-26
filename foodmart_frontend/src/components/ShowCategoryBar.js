import { useState, useEffect } from 'react'
import axios from 'axios'

function ShowCategoryBar({getProducts}) {
  const [category, setCategories] = useState([])

  useEffect(()=>{
    // Post get categories
    axios.post('http://localhost:8080/api/product/getAllCategory')
      .then(function (response) {
        if(response.status===200)
        {
          setCategories(response.data)
        }
        else
        {
          alert("Something went Wrong. Please try Again!!")
        }
      })
      .catch(function (error) {
        console.log(error)
        alert("Invalid email or password")
      });
  }, []);
  // Show categories left panel
  return(
    <ul>
        {category.map((category) => (
          <li key={category.id}><a href="#home" onClick={()=>getProducts(category.id)}>
            <img src={category.img} alt=""/>
            {category.name}</a></li>
        ))}
    </ul>
  )
}

export default ShowCategoryBar