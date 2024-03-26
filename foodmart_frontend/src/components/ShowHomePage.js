import React from 'react'
import ShowHomePageNavBar from './ShowHomePageNavBar'

function ShowHomePage({LogIn, SignUp}) {
  return (
    // Show Homepage form
    <div className="product">
      <ShowHomePageNavBar LogIn={LogIn} SignUp={SignUp} />
      <div style={{ textAlign: "center" }}>
        <img src="PantryLogo.jpg" alt="No Logo" height={700} />
      </div>
    </div>
  )
}

export default ShowHomePage