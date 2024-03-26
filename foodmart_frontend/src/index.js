// Import the necessary modules from React, and from components
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css'

// Create a root element using ReactDOM.createRoot and pass it the HTML element with an id of "root"
const root = ReactDOM.createRoot(document.getElementById('root'));
// Render the App component inside the root element and enable StrictMode
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);