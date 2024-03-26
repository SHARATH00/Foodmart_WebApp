import React from 'react'

function ShowHomePageNavBar({LogIn, SignUp}) {
  return (
    // Show Home Top navigation bar
    <ul>
        <li style={{marginLeft: "44%"}}><a href="#about">Food Mart Fort Wayne</a></li>
        <li style={{float: "right"}}><a href="#about" onClick={SignUp}>Sign Up</a></li>
        <li style={{float: "right"}}><a href="#about" onClick={LogIn}>LogIn</a></li>
    </ul>
  )
}

export default ShowHomePageNavBar