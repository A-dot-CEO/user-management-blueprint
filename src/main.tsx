import { StrictMode } from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter, Route, Routes } from "react-router-dom";

// Import components
import App from "./App";
import Index from "./pages/Index";

// Import the CSS
import "./index.css";

// Render the app
const rootElement = document.getElementById("root");
if (!rootElement) {
  throw new Error("Root element not found");
}
if (!rootElement.innerHTML) {
  const root = ReactDOM.createRoot(rootElement);
  root.render(
    <StrictMode>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<App />}>
            <Route index element={<Index />} />
          </Route>
        </Routes>
      </BrowserRouter>
    </StrictMode>,
  );
}
