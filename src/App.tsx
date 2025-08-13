import { Outlet } from "react-router-dom";

export default function App() {
  return (
    <main className="flex min-h-screen flex-col">
      <Outlet />
    </main>
  );
}
